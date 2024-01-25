provider "google" {
  project     = var.projectId
  region      = var.region
}

resource "google_service_account" "default" {
  account_id   = "service-account-id"
  display_name = "Service Account"
}

resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = var.region
  enable_autopilot = true
}
