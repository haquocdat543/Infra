provider "google" {
  project     = var.projectId
  region      = var.region
}

resource "google_service_account" "default" {
  account_id   = "service-account-id"
  display_name = "Service Account"
}

resource "google_container_cluster" "my_cluster" {
  name     = "my-gke-cluster"
  location = var.zone

  remove_default_node_pool = true

  node_pool {
    name       = "custom-pool"
    initial_node_count = 3
    machine_type       = "n1-standard-2"
    disk_size_gb       = 50
  }

  network_policy {
    enabled = true
  }
}	
