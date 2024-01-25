provider "google" {
  project     = var.projectId
  region      = var.region
}

resource "google_container_registry" "my_gcr" {
  project = var.projectId
}

output "gcr_repository_id" {
  value = google_container_registry.my_gcr.id
}

output "gcr_repository_bucket" {
  value = google_container_registry.my_gcr.bucket_self_link
}

