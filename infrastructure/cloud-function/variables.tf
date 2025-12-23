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

variable "function_names" {
    description = "Cloud Function Names"
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

variable "function_description" {
    description = "Cloud Function Description"
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