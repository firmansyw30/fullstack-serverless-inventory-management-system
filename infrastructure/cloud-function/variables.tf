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

variable "firestore_collection_name" {
    description = "Name of the Firestore collection"
    type        = string
}

# variable "firestore_database_name" {
#     description = "Name of the database"
#     type        = string
# }

variable "service_account_email" {
  description = "The email of the service account to run the function"
  type        = string
}