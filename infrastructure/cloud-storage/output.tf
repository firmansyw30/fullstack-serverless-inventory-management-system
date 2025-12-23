# Cloud Storage Bucket Outputs
output "frontend_bucket_name" {
  description = "Name of the Cloud Storage bucket for frontend hosting"
  value       = google_storage_bucket.frontend_hosting_bucket.name
}

output "frontend_bucket_url" {
  description = "URL of the Cloud Storage bucket"
  value       = google_storage_bucket.frontend_hosting_bucket.url
}

output "frontend_bucket_self_link" {
  description = "Self link of the Cloud Storage bucket"
  value       = google_storage_bucket.frontend_hosting_bucket.self_link
}

output "frontend_website_url" {
  description = "Website URL for the frontend bucket"
  value       = "https://${google_storage_bucket.frontend_hosting_bucket.name}.storage.googleapis.com"
}

# CDN Backend Bucket Outputs
output "backend_bucket_name" {
  description = "Name of the Cloud CDN backend bucket"
  value       = google_compute_backend_bucket.frontend_backend_bucket.name
}

output "backend_bucket_self_link" {
  description = "Self link of the Cloud CDN backend bucket"
  value       = google_compute_backend_bucket.frontend_backend_bucket.self_link
}

output "cdn_enabled" {
  description = "Whether Cloud CDN is enabled"
  value       = google_compute_backend_bucket.frontend_backend_bucket.enable_cdn
}

# Frontend Files Uploaded
output "frontend_files_count" {
  description = "Number of frontend files uploaded"
  value       = length(google_storage_bucket_object.frontend_files)
}

output "frontend_files_list" {
  description = "List of uploaded frontend files"
  value       = keys(google_storage_bucket_object.frontend_files)
}
