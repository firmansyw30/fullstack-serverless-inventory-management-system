variable "api_id" {
  description = "The API ID for the API Gateway"
  type        = string
  default     = "inventory-api"
}

variable "api_config_id" {
  description = "The API config ID for the API Gateway"
  type        = string
  default     = "inventory-api-config"
}

variable "gateway_id" {
  description = "The Gateway ID for the API Gateway"
  type        = string
  default     = "inventory-gateway"
}

variable "gateway_display_name" {
  description = "Display name for the API Gateway"
  type        = string
  default     = "Inventory Management API Gateway"
}

variable "gateway_region" {
  description = "Region for the API Gateway (limited to us-central1, europe-west1, asia-northeast1, asia-southeast1)"
  type        = string
}

variable "create_item_function_uri" {
  description = "URI of the Create Item Cloud Function"
  type        = string
}

variable "get_items_function_uri" {
  description = "URI of the Get Items Cloud Function"
  type        = string
}

variable "update_item_function_uri" {
  description = "URI of the Update Item Cloud Function"
  type        = string
}

variable "delete_item_function_uri" {
  description = "URI of the Delete Item Cloud Function"
  type        = string
}

variable "health_check_function_uri" {
  description = "URI of the Health Check Cloud Function"
  type        = string
}
