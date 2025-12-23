# Archiving Cloud Functions source code files
locals {
  cloud_functions = {
    create_item           = "create_item.py"
    get_items             = "get_items.py"
    update_item           = "update_item.py"
    delete_item           = "delete_item.py"
  }
}


data "archive_file" "cloud_functions_packages" {
  for_each = local.cloud_functions
  type        = "zip"
  source_file = "../../backend/${each.value}"
  output_path = "${replace(each.value, ".py", ".zip")}"
}

# Define Cloud Storage Bucket for Cloud Functions source code
resource "google_storage_bucket" "bucket" {
  name     = var.cloud_storage_bucket_name
  location = var.cloud_storage_location
  uniform_bucket_level_access = var.cloud_storage_uniform_bucket_level_access
}

resource "google_storage_bucket_object" "inventory_source_code" {
  name   = "function-source.zip"
  bucket = google_storage_bucket.bucket.name
  source = "function-source.zip"  # Add path to the zipped function source code
}

# Define Cloud Function
resource "google_cloudfunctions2_function" "serverless_inventory_function" {
  name = var.function_names
  location = var.function_location
  description = var.function_description

  build_config {
    runtime = var.function_runtimes
    source {
      storage_source {
        bucket = google_storage_bucket.bucket.name
        object = google_storage_bucket_object.inventory_source_code.name
      }
    }
  }

  service_config {
    max_instance_count  = var.function_max_instances_count
    available_memory    = var.function_memory
    timeout_seconds     = var.function_timeout_seconds
  }
}