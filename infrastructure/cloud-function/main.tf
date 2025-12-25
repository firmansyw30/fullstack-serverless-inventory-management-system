# Define the list of Cloud Functions to deploy
locals {
  functions = {
    create_item  = {
      entry_point = "create_item"
      description = "Create a new inventory item"
    }
    get_items    = {
      entry_point = "get_items"
      description = "Get inventory items"
    }
    update_item  = {
      entry_point = "update_item"
      description = "Update an inventory item"
    }
    delete_item  = {
      entry_point = "delete_item"
      description = "Delete an inventory item"
    }
    health_check = {
      entry_point = "health_check"
      description = "Health check endpoint"
    }
  }
}

# Archive the entire backend/src directory (includes all .py files + requirements.txt)
data "archive_file" "cloud_functions_package" {
  type        = "zip"
  source_dir  = "${path.module}/../../backend/src"
  output_path = "${path.module}/functions.zip"
}

# Define Cloud Storage Bucket for Cloud Functions source code
resource "google_storage_bucket" "source_code_bucket" {
  name     = var.cloud_storage_bucket_name
  location = var.cloud_storage_location
  uniform_bucket_level_access = var.cloud_storage_uniform_bucket_level_access
}

# Upload the single ZIP file containing all function code
resource "google_storage_bucket_object" "inventory_source_code" {
  name   = "functions-${data.archive_file.cloud_functions_package.output_md5}.zip"
  bucket = google_storage_bucket.source_code_bucket.name
  source = data.archive_file.cloud_functions_package.output_path
}

# Create separate Cloud Functions for each operation
resource "google_cloudfunctions2_function" "inventory_functions" {
  for_each = local.functions

  name        = "${var.function_name_prefix}-${each.key}"
  location    = var.function_location
  description = each.value.description

  build_config {
    runtime     = var.function_runtimes
    entry_point = each.value.entry_point
    source {
      storage_source {
        bucket = google_storage_bucket.source_code_bucket.name
        object = google_storage_bucket_object.inventory_source_code.name
      }
    }
  }

  service_config {
    service_account_email = var.service_account_email
    max_instance_count  = var.function_max_instances_count
    available_memory    = var.function_memory
    timeout_seconds     = var.function_timeout_seconds
    
    environment_variables = {
      FIRESTORE_COLLECTION = var.firestore_collection_name
    }
  }
}

# Allow unauthenticated invocations for API Gateway
resource "google_cloudfunctions2_function_iam_member" "invoker" {
  for_each = local.functions

  project        = google_cloudfunctions2_function.inventory_functions[each.key].project
  location       = google_cloudfunctions2_function.inventory_functions[each.key].location
  cloud_function = google_cloudfunctions2_function.inventory_functions[each.key].name
  
  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}