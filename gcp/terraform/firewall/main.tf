provider "google" {
  project     = var.projectId
  region      = var.region
}

resource "google_compute_network" "vpc_network" {
  name = "vpc-network"
  auto_create_subnetworks = false
}

resource "google_compute_firewall" "test_firewall" {
  name    = "test-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }

  source_tags = ["web"]
}

