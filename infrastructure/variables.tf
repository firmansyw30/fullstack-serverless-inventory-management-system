# Basic Variable
variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "region" {
  description = "Google Cloud Region"
  type        = string
}

variable "zone" {
  description = "Google Cloud Zone"
  type        = string
}

# IAM Service Account
variable "service_account_email" {
  description = "Email from existing IAM Service Account"
  type        = string
}

