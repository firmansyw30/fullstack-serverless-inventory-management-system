# Cloud Storage Bucket Output
output "source_code_bucket_name" {
  description = "Name of the Cloud Storage bucket containing source code"
  value       = google_storage_bucket.source_code_bucket.name
}

output "source_code_bucket_url" {
  description = "URL of the Cloud Storage bucket"
  value       = google_storage_bucket.source_code_bucket.url
}

# Cloud Storage Object Output
output "source_code_object_name" {
  description = "Name of the Cloud Storage object"
  value       = google_storage_bucket_object.inventory_source_code.name
}

# Individual Cloud Function URIs
output "create_item_function_uri" {
  description = "HTTP(S) endpoint URL for create_item function"
  value       = google_cloudfunctions2_function.inventory_functions["create_item"].service_config[0].uri
}

output "get_items_function_uri" {
  description = "HTTP(S) endpoint URL for get_items function"
  value       = google_cloudfunctions2_function.inventory_functions["get_items"].service_config[0].uri
}

output "update_item_function_uri" {
  description = "HTTP(S) endpoint URL for update_item function"
  value       = google_cloudfunctions2_function.inventory_functions["update_item"].service_config[0].uri
}

output "delete_item_function_uri" {
  description = "HTTP(S) endpoint URL for delete_item function"
  value       = google_cloudfunctions2_function.inventory_functions["delete_item"].service_config[0].uri
}

output "health_check_function_uri" {
  description = "HTTP(S) endpoint URL for health_check function"
  value       = google_cloudfunctions2_function.inventory_functions["health_check"].service_config[0].uri
}

# Map of all function names
output "function_names" {
  description = "Map of all deployed Cloud Function names"
  value       = { for k, v in google_cloudfunctions2_function.inventory_functions : k => v.name }
}

# Map of all function URIs
output "function_uris" {
  description = "Map of all deployed Cloud Function URIs"
  value       = { for k, v in google_cloudfunctions2_function.inventory_functions : k => v.service_config[0].uri }
}
