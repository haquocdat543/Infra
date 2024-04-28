resource "google_compute_network" "vpc_network" {
  name = "vpc-network-${random_id.bucket_prefix.hex}"
  auto_create_subnetworks = true
}


