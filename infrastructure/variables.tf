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
  default     = ""
}

variable "service_account_id" {
  description = "The ID of the service account to create"
  type        = string
}

variable "service_account_display_name" {
  description = "Display name for the service account"
  type        = string
}

# Cloud Storage Variables
variable "cloud_storage_location" {
  description = "Cloud Storage Bucket Location"
  type        = string
}

variable "cloud_storage_bucket_name" {
  description = "Cloud Storage Bucket Name for Cloud Functions Source Code"
  type        = string
}

variable "cloud_storage_uniform_bucket_level_access" {
  description = "Uniform Bucket Level Access for Cloud Storage Bucket"
  type        = bool
}

# Cloud Function Variables
variable "function_name_prefix" {
  description = "Prefix for Cloud Function names"
  type        = string
}

variable "function_runtimes" {
  description = "Cloud Function Runtimes"
  type        = string
}

variable "function_location" {
  description = "Cloud Function Location"
  type        = string
}

variable "function_max_instances_count" {
  description = "Maximum Instances for Cloud Functions"
  type        = number
}

variable "function_memory" {
  description = "Memory Allocation for Cloud Functions"
  type        = string
}

variable "function_timeout_seconds" {
  description = "Timeout Duration for Cloud Functions in Seconds"
  type        = number
}

# Frontend Cloud Storage Variables
variable "frontend_bucket_name" {
  description = "Name of the Cloud Storage bucket for hosting React frontend"
  type        = string
}

variable "frontend_bucket_location" {
  description = "Location of the Cloud Storage bucket for frontend"
  type        = string
  default     = "US"
}

variable "frontend_uniform_bucket_level_access" {
  description = "Enable uniform bucket-level access for the frontend bucket"
  type        = bool
  default     = true
}

variable "backend_bucket_name" {
  description = "Name of the Cloud CDN backend bucket"
  type        = string
}

variable "enable_cdn" {
  description = "Enable Cloud CDN for the backend bucket"
  type        = bool
  default     = true
}

variable "cdn_cache_mode" {
  description = "Cloud CDN cache mode"
  type        = string
  default     = "CACHE_ALL_STATIC"
}

variable "cdn_negative_caching" {
  description = "Enable negative caching for Cloud CDN"
  type        = bool
  default     = true
}

variable "cdn_client_ttl" {
  description = "Client TTL for Cloud CDN in seconds"
  type        = number
  default     = 3600
}

variable "cdn_default_ttl" {
  description = "Default TTL for Cloud CDN in seconds"
  type        = number
  default     = 3600
}

variable "cdn_max_ttl" {
  description = "Max TTL for Cloud CDN in seconds"
  type        = number
  default     = 86400
}

# API Gateway Variables
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

# Cloud Firestore Variables
variable "firestore_database_name" {
  description = "Name of the Firestore database"
  type        = string
}

variable "firestore_location" {
  description = "Location of the Firestore database"
  type        = string
}

variable "firestore_database_type" {
  description = "Type of Firestore database"
  type        = string
}

variable "firestore_items_collection_name" {
  description = "Name of the Firestore collection for inventory items"
  type        = string
}
