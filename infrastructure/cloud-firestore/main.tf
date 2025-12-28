# Enable Firestore API
resource "google_project_service" "firestore_api" {
  service = "firestore.googleapis.com"
}

# (Optional) Firestore Index
resource "google_firestore_index" "items_by_category" {
  project    = var.project_id
  # database   = var.firestore_database_name
  database   = "inventory-db"
  collection = var.firestore_items_collection_name

  fields {
    field_path = "category"
    order      = "ASCENDING"
  }

  fields {
    field_path = "createdAt"
    order      = "DESCENDING"
  }

  depends_on = [
    google_project_service.firestore_api
  ]
}

locals {
  firestore_environment_variables = {
    FIRESTORE_COLLECTION = var.firestore_items_collection_name
  }
}
