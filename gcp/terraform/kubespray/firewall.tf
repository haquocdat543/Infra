resource "google_compute_firewall" "allow-all_firewall" {
  name    = "allow-all-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "All"
    ports    = []
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["http-server"]
}
