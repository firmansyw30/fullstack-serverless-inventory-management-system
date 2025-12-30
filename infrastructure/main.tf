# Cloud Functions module for inventory management
module "cloud-function" {
  source                                    = "./cloud-function"
  cloud_storage_bucket_name                 = var.cloud_storage_bucket_name
  cloud_storage_uniform_bucket_level_access = var.cloud_storage_uniform_bucket_level_access
  cloud_storage_location                    = var.cloud_storage_location
  function_name_prefix                      = var.function_name_prefix
  function_runtimes                         = var.function_runtimes
  function_location                         = var.function_location
  function_max_instances_count              = var.function_max_instances_count
  function_memory                           = var.function_memory
  function_timeout_seconds                  = var.function_timeout_seconds
  firestore_collection_name                 = var.firestore_items_collection_name
  service_account_email                     = module.iam.service_account_email
  firestore_database_name                   = var.firestore_database_name
  # Ensure IAM roles are created before Cloud Functions
  depends_on = [module.iam]
}

# IAM module
module "iam" {
  source                       = "./iam"
  project_id                   = var.project_id
  service_account_id           = var.service_account_id
  service_account_display_name = var.service_account_display_name
}

# Cloud Firestore module for data persistence
module "cloud-firestore" {
  source     = "./cloud-firestore"
  project_id = var.project_id
  firestore_location              = var.firestore_location
  database_type                   = var.firestore_database_type
  firestore_database_name         = var.firestore_database_name
  firestore_items_collection_name = var.firestore_items_collection_name
  depends_on                      = [module.iam]
}

# Cloud Storage module for frontend hosting
module "cloud-storage" {
  source                               = "./cloud-storage"
  frontend_bucket_name                 = var.frontend_bucket_name
  frontend_bucket_location             = var.frontend_bucket_location
  frontend_uniform_bucket_level_access = var.frontend_uniform_bucket_level_access
  backend_bucket_name                  = var.backend_bucket_name
  enable_cdn                           = var.enable_cdn
  cdn_cache_mode                       = var.cdn_cache_mode
  cdn_negative_caching                 = var.cdn_negative_caching
  cdn_client_ttl                       = var.cdn_client_ttl
  cdn_default_ttl                      = var.cdn_default_ttl
  cdn_max_ttl                          = var.cdn_max_ttl
  main_page_suffix                     = var.main_page_suffix
  not_found_page                       = var.not_found_page
  # force_destroy                       = var.force_destroy
  allow_destroy                        = var.allow_destroy
}

# API Gateway module for REST API exposure
module "api-gateway" {
  source                    = "./api-gateway"
  api_id                    = var.api_id
  api_config_id             = var.api_config_id
  gateway_id                = var.gateway_id
  gateway_region            = var.gateway_region
  gateway_display_name      = var.gateway_display_name
  release_stage             = var.release_stage
  create_item_function_uri  = module.cloud-function.create_item_function_uri
  get_items_function_uri    = module.cloud-function.get_items_function_uri
  update_item_function_uri  = module.cloud-function.update_item_function_uri
  delete_item_function_uri  = module.cloud-function.delete_item_function_uri
  health_check_function_uri = module.cloud-function.health_check_function_uri

  # Ensure Cloud Functions are created before API Gateway
  depends_on = [module.cloud-function]
}
