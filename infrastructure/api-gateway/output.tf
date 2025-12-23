output "api_id" {
  description = "The API ID"
  value       = google_api_gateway_api.inventory_api.api_id
}

output "api_config_id" {
  description = "The API Config ID"
  value       = google_api_gateway_api_config.inventory_api_config.api_config_id
}

output "gateway_id" {
  description = "The Gateway ID"
  value       = google_api_gateway_gateway.inventory_gateway.gateway_id
}

output "gateway_default_host" {
  description = "The default host of the API Gateway"
  value       = google_api_gateway_gateway.inventory_gateway.default_hostname
}

output "gateway_url" {
  description = "The full URL of the API Gateway"
  value       = "https://${google_api_gateway_gateway.inventory_gateway.default_hostname}"
}
