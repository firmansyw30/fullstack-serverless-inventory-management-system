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

output "frontend_files_count" {
  description = "Number of frontend files uploaded to the bucket"
  value       = module.cloud-storage.frontend_files_count
}

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
output "cloud_function_name" {
  description = "Name of the deployed Cloud Function"
  value       = module.cloud-function.function_name
}

output "cloud_function_uri" {
  description = "HTTP(S) endpoint URL of the Cloud Function for API calls"
  value       = module.cloud-function.function_uri
}

output "cloud_function_location" {
  description = "Location of the deployed Cloud Function"
  value       = module.cloud-function.function_location
}

output "source_code_bucket_name" {
  description = "Name of the Cloud Storage bucket containing Cloud Functions source code"
  value       = module.cloud-function.source_code_bucket_name
}

output "archived_source_files" {
  description = "List of archived Python files deployed as Cloud Functions"
  value       = module.cloud-function.archived_source_files
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

