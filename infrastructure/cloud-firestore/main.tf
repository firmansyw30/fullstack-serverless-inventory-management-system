resource "google_project_service" "firestore_api" {
  service = "firestore.googleapis.com"
  disable_on_destroy = false
}

resource "google_firestore_database" "inventory_database" {
  project      = var.project_id
  name         = var.firestore_database_name
  location_id  = var.firestore_location
  type         = var.database_type
  depends_on = [
    google_project_service.firestore_api
  ]

  # skip execution if resource is already existed
  lifecycle {
    ignore_changes = all
  }
}

# Firestore Index
resource "google_firestore_index" "items_by_category" {
  project    = var.project_id
  database   = var.firestore_database_name
  #database   = "inventory-db"
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

  lifecycle {
    ignore_changes = [  ]
  }
}

locals {
  firestore_environment_variables = {
    FIRESTORE_COLLECTION = var.firestore_items_collection_name
    FIRESTORE_DATABASE   = var.firestore_database_name
  }
}
