# API Gateway API resource

resource "google_project_service" "api_gateway_api" {
  service = "apigateway.googleapis.com"
  disable_on_destroy = false
}

locals {
  api_config_id = "${var.api_config_id}-${var.release_stage}"
}

resource "google_api_gateway_api" "inventory_api" {
  provider = google-beta
  api_id   = var.api_id
}

# API Gateway API Config with OpenAPI specification
resource "google_api_gateway_api_config" "inventory_api_config" {
  provider        = google-beta
  api             = google_api_gateway_api.inventory_api.api_id
  api_config_id   = local.api_config_id
  openapi_documents {
    document {
      path = "openapi.yaml"
      contents = base64encode(templatefile("${path.module}/openapi.yaml", {
        create_item_url  = coalesce(var.create_item_function_uri, "")
        get_items_url    = coalesce(var.get_items_function_uri, "")
        update_item_url  = coalesce(var.update_item_function_uri, "")
        delete_item_url  = coalesce(var.delete_item_function_uri, "")
        health_check_url = coalesce(var.health_check_function_uri, "")
      }))
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    google_api_gateway_api.inventory_api
  ]
}

# API Gateway resource
resource "google_api_gateway_gateway" "inventory_gateway" {
  provider      = google-beta
  api_config    = google_api_gateway_api_config.inventory_api_config.id
  gateway_id    = var.gateway_id
  region        = var.gateway_region
  display_name  = var.gateway_display_name
}
