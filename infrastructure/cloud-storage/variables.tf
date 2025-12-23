# Frontend Bucket Configuration Variables
variable "frontend_bucket_name" {
  description = "Name of the Cloud Storage bucket for hosting React frontend"
  type        = string
}

variable "frontend_bucket_location" {
  description = "Location of the Cloud Storage bucket (e.g., US, EU, ASIA-SOUTHEAST2)"
  type        = string
  default     = "US"
}

variable "frontend_uniform_bucket_level_access" {
  description = "Enable uniform bucket-level access for the frontend bucket"
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Allow Terraform to destroy the bucket even if it contains objects"
  type        = bool
  default     = false
}

variable "allow_destroy" {
  description = "Allow destruction of the bucket with lifecycle rules"
  type        = bool
  default     = false
}

variable "enable_versioning" {
  description = "Enable versioning for the bucket"
  type        = bool
  default     = false
}

# CORS Configuration Variables
variable "cors_origins" {
  description = "CORS origins allowed for the frontend bucket"
  type        = list(string)
  default     = ["*"]
}

variable "cors_methods" {
  description = "CORS methods allowed for the frontend bucket"
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "DELETE"]
}

variable "cors_response_headers" {
  description = "CORS response headers for the frontend bucket"
  type        = list(string)
  default     = ["Content-Type", "Authorization", "X-Requested-With"]
}

variable "cors_max_age_seconds" {
  description = "CORS max age in seconds"
  type        = number
  default     = 3600
}

# Website Configuration Variables
variable "main_page_suffix" {
  description = "Main page suffix for website hosting"
  type        = string
  default     = "index.html"
}

variable "not_found_page" {
  description = "Not found page for website hosting"
  type        = string
  default     = "index.html"
}

# CDN Backend Bucket Variables
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
  description = "Cloud CDN cache mode (CACHE_ALL_STATIC, INVALIDATE_ON_CHANGES, or USE_ORIGIN_HEADERS)"
  type        = string
  default     = "CACHE_ALL_STATIC"
}

variable "cdn_negative_caching" {
  description = "Enable negative caching for Cloud CDN"
  type        = bool
  default     = true
}

variable "cdn_negative_caching_max_age_sec" {
  description = "Maximum age in seconds for negative caching"
  type        = number
  default     = 120
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
