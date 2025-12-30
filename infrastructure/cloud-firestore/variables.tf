variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "firestore_location" {
  description = "Location of the Firestore database"
  type        = string
  # Options: nam5 (North America), eur3 (Europe), asia1 (Asia), etc.
}

variable "database_type" {
  description = "Type of Firestore database"
  type        = string
  # Valid options: FIRESTORE_NATIVE or DATASTORE_MODE
}

variable "firestore_items_collection_name" {
  description = "Name of the Firestore collection for inventory items"
  type        = string
}

variable "firestore_database_name" {
  description = "Name of the Firestore database"
  type        = string
}