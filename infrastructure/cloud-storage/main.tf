resource "google_project_service" "cloud_storage_api" {
  service = "storage.googleapis.com"
  disable_on_destroy = false
}

# Cloud Storage Bucket for hosting React frontend application
resource "google_storage_bucket" "frontend_hosting_bucket" {
  name                        = var.frontend_bucket_name
  location                    = var.frontend_bucket_location
  uniform_bucket_level_access = var.frontend_uniform_bucket_level_access
  force_destroy               = var.force_destroy

  website {
    main_page_suffix = var.main_page_suffix
    not_found_page   = var.not_found_page
  }

  cors {
    origin          = var.cors_origins
    method          = var.cors_methods
    response_header = var.cors_response_headers
    max_age_seconds = var.cors_max_age_seconds
  }

  versioning {
    enabled = var.enable_versioning
  }

  lifecycle {
    ignore_changes = all
    #force_destroy = var.force_destroy
    #prevent_destroy = var.prevent_destroy
  }
#   lifecycle {
#     prevent_destroy = !var.allow_destroy
#   }
}

# Make bucket public for website hosting (public read access)
resource "google_storage_bucket_iam_member" "public_read_access" {
  bucket = google_storage_bucket.frontend_hosting_bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

# Upload React build artifacts to the bucket
resource "google_storage_bucket_object" "frontend_files" {
  for_each = toset(try(fileset("${path.module}/../../frontend/build", "**/*"), []))
  
  bucket = google_storage_bucket.frontend_hosting_bucket.name
  name   = each.value
  source = "${path.module}/../../frontend/build/${each.value}"

  content_type = lookup(
    {
      html  = "text/html; charset=utf-8"
      css   = "text/css; charset=utf-8"
      js    = "application/javascript; charset=utf-8"
      json  = "application/json; charset=utf-8"
      png   = "image/png"
      jpg   = "image/jpeg"
      jpeg  = "image/jpeg"
      gif   = "image/gif"
      svg   = "image/svg+xml"
      ico   = "image/x-icon"
      webp  = "image/webp"
      woff  = "application/font-woff"
      woff2 = "application/font-woff2"
      ttf   = "application/font-ttf"
      eot   = "application/vnd.ms-fontobject"
    },
    lower(element(reverse(split(".", each.value)), 0)),
    "application/octet-stream"
  )

  depends_on = [google_storage_bucket.frontend_hosting_bucket]
}

# Create a Cloud CDN policy for caching (optional but recommended)
resource "google_compute_backend_bucket" "frontend_backend_bucket" {
  name            = var.backend_bucket_name
  bucket_name     = google_storage_bucket.frontend_hosting_bucket.name
  enable_cdn      = var.enable_cdn
  cdn_policy {
    cache_mode        = var.cdn_cache_mode
    negative_caching  = var.cdn_negative_caching
    client_ttl        = var.cdn_client_ttl
    default_ttl       = var.cdn_default_ttl
    max_ttl           = var.cdn_max_ttl
  }
}
