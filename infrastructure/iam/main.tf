# Service Account for Cloud Functions
resource "google_service_account" "cloud_functions_sa" {
  account_id   = var.service_account_id
  display_name = var.service_account_display_name
  description  = "Service account for Cloud Functions to access Cloud Storage and Firestore"

  lifecycle {
    ignore_changes = [account_id]
  }
}

# IAM Role Binding - Cloud Functions Runner
resource "google_project_iam_member" "cloud_functions_runner" {
  project = var.project_id
  role    = "roles/cloudfunctions.developer"
  member  = "serviceAccount:${google_service_account.cloud_functions_sa.email}"
}

# IAM Role Binding - Cloud Functions Service Agent
resource "google_project_iam_member" "cloud_functions_service_agent" {
  project = var.project_id
  role    = "roles/cloudfunctions.serviceAgent"
  member  = "serviceAccount:${google_service_account.cloud_functions_sa.email}"
}

# IAM Role Binding - Cloud Storage Object Admin (for reading source code)
resource "google_project_iam_member" "storage_object_admin" {
  project = var.project_id
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${google_service_account.cloud_functions_sa.email}"
}

# IAM Role Binding - Cloud Storage Viewer
resource "google_project_iam_member" "storage_viewer" {
  project = var.project_id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.cloud_functions_sa.email}"
}

# Public Read Access to Cloud Storage Objects (if needed)
resource "google_project_iam_member" "public_storage_viewer" {
  project = var.project_id
  role    = "roles/storage.objectViewer"
  member  = "allUsers"
}

# IAM Role Binding - Firestore Database Admin (for CRUD operations on Firestore)
resource "google_project_iam_member" "firestore_admin" {
  project = var.project_id
  role    = "roles/datastore.user"
  member  = "serviceAccount:${google_service_account.cloud_functions_sa.email}"
}

# IAM Role Binding - Service Account User (to allow API Gateway to use this service account)
resource "google_project_iam_member" "service_account_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.cloud_functions_sa.email}"
}

# IAM Role Binding - API Gateway Service Agent
resource "google_project_iam_member" "api_gateway_service_agent" {
  project = var.project_id
  role    = "roles/apigateway.serviceAgent"
  member  = "serviceAccount:${google_service_account.cloud_functions_sa.email}"
}

# IAM Role Binding - Cloud Run Invoker (for invoking Cloud Functions)
resource "google_project_iam_member" "cloud_run_invoker" {
  project = var.project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.cloud_functions_sa.email}"
}

# IAM Role Binding - Cloud Functions Invoker (additional for Cloud Function invocation)
resource "google_project_iam_member" "cloud_functions_invoker" {
  project = var.project_id
  role    = "roles/cloudfunctions.invoker"
  member  = "serviceAccount:${google_service_account.cloud_functions_sa.email}"
}

# IAM Role Binding - Firestore Database Admin (full admin access for Firestore)
resource "google_project_iam_member" "firestore_database_admin" {
  project = var.project_id
  role    = "roles/datastore.owner"
  member  = "serviceAccount:${google_service_account.cloud_functions_sa.email}"
}

# IAM Role Binding - Cloud Storage Bucket Admin (full admin access for buckets)
resource "google_project_iam_member" "storage_bucket_admin" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.cloud_functions_sa.email}"
}

# IAM Role Binding - Logs Writer (for writing logs from Cloud Functions)
resource "google_project_iam_member" "logs_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.cloud_functions_sa.email}"
}

# IAM Role Binding - Monitoring Metric Writer (for metrics from Cloud Functions)
resource "google_project_iam_member" "monitoring_metric_writer" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.cloud_functions_sa.email}"
}

# IAM Role Binding - Artifact Registry Reader (for container images if using Docker)
resource "google_project_iam_member" "artifact_registry_reader" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.cloud_functions_sa.email}"
}

# IAM Role Binding - Service Account Token Creator (for generating access tokens)
resource "google_project_iam_member" "service_account_token_creator" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${google_service_account.cloud_functions_sa.email}"
}

# IAM Role Binding - Editor for API Gateway (full control over API Gateway)
resource "google_project_iam_member" "api_gateway_editor" {
  project = var.project_id
  role    = "roles/apigateway.admin"
  member  = "serviceAccount:${google_service_account.cloud_functions_sa.email}"
}

# Service Account Key (optional - for local development or CI/CD)
resource "google_service_account_key" "cloud_functions_sa_key" {
  service_account_id = google_service_account.cloud_functions_sa.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}
