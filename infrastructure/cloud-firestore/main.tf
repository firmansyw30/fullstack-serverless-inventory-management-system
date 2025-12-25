# ============================================================
# Cloud Firestore Configuration for Inventory Management
# ============================================================

# Enable Firestore API
resource "google_project_service" "firestore_api" {
  service            = "firestore.googleapis.com"
  disable_on_destroy = false
}

# Create Firestore Database in Native mode
resource "google_firestore_database" "inventory_database" {
  project     = var.project_id
  name        = var.database_name
  location_id = var.firestore_location
  type        = var.database_type

  # Set as default database
  depends_on = [google_project_service.firestore_api]
}

# Create Firestore Index for querying items by category and creation date
resource "google_firestore_index" "items_by_category" {
  project    = var.project_id
  database   = google_firestore_database.inventory_database.name
  collection = var.items_collection_name
  query_scope = "COLLECTION"

  fields {
    field_path = "category"
    order      = "ASCENDING"
  }

  fields {
    field_path = "createdAt"
    order      = "DESCENDING"
  }

  depends_on = [google_firestore_database.inventory_database]
}

# Create Firestore Index for querying items by price range and quantity
resource "google_firestore_index" "items_by_price" {
  project    = var.project_id
  database   = google_firestore_database.inventory_database.name
  collection = var.items_collection_name
  query_scope = "COLLECTION"

  fields {
    field_path = "price"
    order      = "ASCENDING"
  }

  fields {
    field_path = "quantity"
    order      = "DESCENDING"
  }

  depends_on = [google_firestore_database.inventory_database]
}

# Create Firestore Index for searching by name and category
resource "google_firestore_index" "items_by_name_category" {
  project    = var.project_id
  database   = google_firestore_database.inventory_database.name
  collection = var.items_collection_name
  query_scope = "COLLECTION"

  fields {
    field_path = "name"
    order      = "ASCENDING"
  }

  fields {
    field_path = "category"
    order      = "ASCENDING"
  }

  depends_on = [google_firestore_database.inventory_database]
}

# # Firestore Security Rules - Require authentication and proper permissions
# resource "google_firestore_security_rules" "inventory_rules" {
#   project = var.project_id

#   rules_v1 {
#     rules = base64encode(templatefile("${path.module}/firestore.rules", {
#       project_id = var.project_id
#     }))
#   }

#   depends_on = [google_firestore_database.inventory_database]
# }

# # Optional: Backup Configuration for Firestore (daily backup with retention)
# resource "google_firestore_backup_schedule" "daily_backup" {
#   project  = var.project_id
#   database = google_firestore_database.inventory_database.name

#   # Backup retention duration
#   retention = "86400s"  # 24 hours

#   # Daily recurrence
#   daily_recurrence {}

#   depends_on = [google_firestore_database.inventory_database]
# }

# Cloud Function Environment Variable - FIRESTORE_COLLECTION
# This will be used by Cloud Functions to reference the items collection
locals {
  firestore_environment_variables = {
    FIRESTORE_COLLECTION = var.items_collection_name
    GCP_PROJECT          = var.project_id
  }
}
