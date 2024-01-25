provider "google" {
  project     = var.projectId
  region      = var.region
}

resource "google_compute_network" "vpc_network" {
  name = "vpc-network"
  auto_create_subnetworks = true
}

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

resource "google_service_account" "test_sa" {
  account_id   = "my-custom-sa"
  display_name = "Custom SA for VM Instance"
}

resource "google_compute_instance" "master" {
  name         = "master-instance"
  machine_type = "n2-standard-2"
  zone         = "asia-northeast1-a"

  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {}
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = file("./scripts/rbmq.sh")

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.test_sa.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "worker" {
  name         = "worker-instance"
  machine_type = "n2-standard-2"
  zone         = "asia-northeast1-a"

  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {}
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = file("./scripts/rbmq.sh")

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.test_sa.email
    scopes = ["cloud-platform"]
  }
}

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

