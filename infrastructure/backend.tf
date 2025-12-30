terraform {
  backend "gcs" {
    bucket  = "inventory-terraform-state-1"    # Ganti dengan nama bucket (misal: inventory-terraform-state)
    prefix  = "terraform/state"     # Folder di dalam bucket
  }
}