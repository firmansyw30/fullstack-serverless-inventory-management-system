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

# Cloud Function Output
output "function_name" {
  description = "Name of the Cloud Function"
  value       = google_cloudfunctions2_function.serverless_inventory_function.name
}

output "function_id" {
  description = "Fully qualified identifier of the Cloud Function"
  value       = google_cloudfunctions2_function.serverless_inventory_function.id
}

output "function_uri" {
  description = "HTTP(S) endpoint URL of the Cloud Function"
  value       = google_cloudfunctions2_function.serverless_inventory_function.service_config[0].uri
}

output "function_location" {
  description = "Location of the Cloud Function"
  value       = google_cloudfunctions2_function.serverless_inventory_function.location
}

# Archived Source Files Output
output "archived_source_files" {
  description = "Archive file outputs for all Cloud Functions"
  value = {
    for name, archive in data.archive_file.cloud_functions_packages :
    name => {
      output_path = archive.output_path
      output_size = archive.output_size
      output_md5  = archive.output_base64sha256
    }
  }
}
