# ============================================================
# Root Outputs - Aggregating all module outputs
# ============================================================

# ============================================================
# IAM Outputs
# ============================================================
output "service_account_id" {
  description = "The ID of the created service account"
  value       = module.iam.service_account_id
}

output "service_account_email" {
  description = "The email of the created service account"
  value       = module.iam.service_account_email
}

output "service_account_unique_id" {
  description = "The unique ID of the created service account"
  value       = module.iam.service_account_unique_id
}

# ============================================================
# Cloud Storage Outputs - Frontend Hosting
# ============================================================
output "frontend_bucket_name" {
  description = "Name of the Cloud Storage bucket for frontend hosting"
  value       = module.cloud-storage.frontend_bucket_name
}

output "frontend_bucket_url" {
  description = "URL of the frontend hosting bucket"
  value       = module.cloud-storage.frontend_bucket_url
}

output "frontend_website_url" {
  description = "Website URL for accessing the React frontend application"
  value       = module.cloud-storage.frontend_website_url
}

# output "frontend_files_count" {
#   description = "Number of frontend files uploaded to the bucket"
#   value       = module.cloud-storage.frontend_files_count
# }

# ============================================================
# Cloud CDN Outputs
# ============================================================
output "backend_bucket_name" {
  description = "Name of the Cloud CDN backend bucket"
  value       = module.cloud-storage.backend_bucket_name
}

output "cdn_enabled" {
  description = "Whether Cloud CDN is enabled for the frontend"
  value       = module.cloud-storage.cdn_enabled
}

# ============================================================
# Cloud Functions Outputs
# ============================================================
output "cloud_function_names" {
  description = "Map of all deployed Cloud Function names"
  value       = module.cloud-function.function_names
}

output "cloud_function_uris" {
  description = "Map of all Cloud Function URIs"
  value       = module.cloud-function.function_uris
}

output "create_item_function_uri" {
  description = "HTTP(S) endpoint URL for create_item function"
  value       = module.cloud-function.create_item_function_uri
}

output "get_items_function_uri" {
  description = "HTTP(S) endpoint URL for get_items function"
  value       = module.cloud-function.get_items_function_uri
}

output "update_item_function_uri" {
  description = "HTTP(S) endpoint URL for update_item function"
  value       = module.cloud-function.update_item_function_uri
}

output "delete_item_function_uri" {
  description = "HTTP(S) endpoint URL for delete_item function"
  value       = module.cloud-function.delete_item_function_uri
}

output "health_check_function_uri" {
  description = "HTTP(S) endpoint URL for health_check function"
  value       = module.cloud-function.health_check_function_uri
}

output "source_code_bucket_name" {
  description = "Name of the Cloud Storage bucket containing Cloud Functions source code"
  value       = module.cloud-function.source_code_bucket_name
}

# ============================================================
# API Gateway Outputs
# ============================================================
output "api_gateway_url" {
  description = "The full URL of the API Gateway for accessing backend services"
  value       = module.api-gateway.gateway_url
}

output "api_gateway_id" {
  description = "The Gateway ID for the API Gateway"
  value       = module.api-gateway.gateway_id
}

output "api_id" {
  description = "The API ID for the API Gateway"
  value       = module.api-gateway.api_id
}

output "api_config_id" {
  description = "The API Config ID for the API Gateway"
  value       = module.api-gateway.api_config_id
}

# ============================================================
# Cloud Firestore Outputs
# ============================================================
output "firestore_database_name" {
  description = "The name of the Firestore database"
  value       = module.cloud-firestore.database_name
}

output "firestore_database_location" {
  description = "The location of the Firestore database"
  value       = module.cloud-firestore.database_location
}

output "firestore_database_type" {
  description = "The type of Firestore database"
  value       = module.cloud-firestore.database_type
}

output "firestore_items_collection" {
  description = "The name of the items collection in Firestore"
  value       = module.cloud-firestore.firestore_items_collection_name
}

output "firestore_environment_variables" {
  description = "Environment variables for Cloud Functions to access Firestore"
  value       = module.cloud-firestore.firestore_environment_variables
}

# ============================================================
# Project Information
# ============================================================
output "project_id" {
  description = "Google Cloud Project ID"
  value       = var.project_id
}

output "region" {
  description = "Primary Google Cloud Region"
  value       = var.region
}

output "zone" {
  description = "Primary Google Cloud Zone"
  value       = var.zone
}

