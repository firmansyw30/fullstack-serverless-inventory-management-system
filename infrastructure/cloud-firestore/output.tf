# output "database_id" {
#   description = "The database ID"
#   value       = google_firestore_database.inventory_database.name
# }

# output "database_name" {
#   description = "The Firestore database name"
#   value       = google_firestore_database.inventory_database.name
# }

# output "database_location" {
#   description = "The location of the Firestore database"
#   value       = google_firestore_database.inventory_database.location_id
# }

# output "database_type" {
#   description = "The type of Firestore database"
#   value       = google_firestore_database.inventory_database.type
# }

# output "database_name" {
#   description = "Name of the Database"
#   value       = google_firestore_database.default.name
# }

# output "firestore_items_collection_name" {
#   description = "Name of the items collection"
#   value       = var.firestore_items_collection_name
# }

# output "firestore_environment_variables" {
#   description = "Environment variables for Cloud Functions to access Firestore"
#   value       = local.firestore_environment_variables
# }

output "firestore_items_collection_name" {
  description = "Name of the items collection"
  value       = var.firestore_items_collection_name
}

output "firestore_environment_variables" {
  description = "Environment variables for Cloud Functions to access Firestore"
  value       = local.firestore_environment_variables
}

