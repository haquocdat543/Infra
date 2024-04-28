output "master-internal-ip" {
  description = "Master private IP"
  value       = google_compute_instance.master.network_interface.0.network_ip
}

output "master-external-ip" {
  description = "Master public IP"
  value       = google_compute_instance.master.network_interface.0.access_config.0.nat_ip
}

output "worker-internal-ip" {
  description = "Worker private IP"
  value       = google_compute_instance.worker.network_interface.0.network_ip
}

output "worker-external-ip" {
  description = "Worker public IP"
  value       = google_compute_instance.worker.network_interface.0.access_config.0.nat_ip
}


