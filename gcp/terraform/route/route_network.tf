resource "google_compute_route" "route_network" {
  name        = "network-route"
  dest_range  = "0.0.0.0/0"
  network     = google_compute_network.vpc_network.name
  next_hop_ip = "10.132.1.5"
  priority    = 100
}

