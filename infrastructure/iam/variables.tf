variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "service_account_id" {
  description = "The ID of the service account"
  type        = string
  default     = "inventory-cloud-functions-sa"
}

variable "service_account_display_name" {
  description = "Display name for the service account"
  type        = string
  default     = "Inventory Cloud Functions Service Account"
}
