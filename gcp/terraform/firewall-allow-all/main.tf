provider "google" {
  project     = var.projectId
  region      = var.region
}

resource "google_compute_network" "vpc_network" {
  name = "vpc-network"
  auto_create_subnetworks = false
}

resource "google_compute_firewall" "allow-all_firewall" {
  name    = "allow-all-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "All"
    ports    = []
  }
}

