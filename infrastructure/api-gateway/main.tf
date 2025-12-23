# API Gateway API resource
resource "google_api_gateway_api" "inventory_api" {
  provider = google-beta
  api_id   = var.api_id
}

# API Gateway API Config with OpenAPI specification
resource "google_api_gateway_api_config" "inventory_api_config" {
  provider        = google-beta
  api             = google_api_gateway_api.inventory_api.api_id
  api_config_id   = var.api_config_id
  openapi_documents {
    document {
      path = "openapi.yaml"
      contents = base64encode(templatefile("${path.module}/openapi.yaml", {
        create_item_url = var.create_item_function_uri
        get_items_url   = var.get_items_function_uri
        update_item_url = var.update_item_function_uri
        delete_item_url = var.delete_item_function_uri
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
  display_name  = var.gateway_display_name
}
