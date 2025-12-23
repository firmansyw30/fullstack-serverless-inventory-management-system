output "service_account_id" {
  description = "The ID of the service account"
  value       = google_service_account.cloud_functions_sa.account_id
}

output "service_account_email" {
  description = "The email of the service account"
  value       = google_service_account.cloud_functions_sa.email
}

output "service_account_unique_id" {
  description = "The unique ID of the service account"
  value       = google_service_account.cloud_functions_sa.unique_id
}

output "service_account_name" {
  description = "The fully qualified name of the service account"
  value       = google_service_account.cloud_functions_sa.name
}

output "service_account_key_private_key_id" {
  description = "The private key ID of the service account key"
  value       = google_service_account_key.cloud_functions_sa_key.name
  sensitive   = true
}
