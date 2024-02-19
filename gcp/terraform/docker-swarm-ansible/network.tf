resource "google_compute_network" "vpc_network" {
  name = "vpc-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = "test-subnetwork"
  ip_cidr_range = "10.0.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}
