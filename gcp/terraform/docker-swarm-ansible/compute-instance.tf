resource "google_compute_instance" "master1" {
  name         = "master1-instance"
  machine_type = "n2-standard-2"
  zone         = "asia-northeast1-a"
  allow_stopping_for_update = true

  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-stream-9"
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
    subnetwork = google_compute_subnetwork.vpc_subnetwork.name
    access_config {}
    network_ip = "10.0.0.101"
  }

  metadata = {
    ssh_keys = var.ssh_key
  }

  metadata_startup_script = file("./scripts/rbmq.sh")

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.test_sa.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "master2" {
  name         = "master2-instance"
  machine_type = "n2-standard-2"
  zone         = "asia-northeast1-a"

  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-stream-9"
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
    subnetwork = google_compute_subnetwork.vpc_subnetwork.name
    access_config {}
    network_ip = "10.0.0.102"
  }

  metadata = {
    ssh_keys = var.ssh_key
  }

  metadata_startup_script = file("./scripts/rbmq.sh")

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.test_sa.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "worker1" {
  name         = "worker1-instance"
  machine_type = "n2-standard-2"
  zone         = "asia-northeast1-a"

  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-stream-9"
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
    subnetwork = google_compute_subnetwork.vpc_subnetwork.name
    access_config {}
    network_ip = "10.0.0.103"
  }

  metadata = {
    ssh_keys = var.ssh_key
  }

  metadata_startup_script = file("./scripts/rbmq.sh")

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.test_sa.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "worker2" {
  name         = "worker2-instance"
  machine_type = "n2-standard-2"
  zone         = "asia-northeast1-a"

  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-stream-9"
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
    subnetwork = google_compute_subnetwork.vpc_subnetwork.name
    access_config {}
    network_ip = "10.0.0.104"
  }

  metadata = {
    ssh_keys = var.ssh_key
  }

  metadata_startup_script = file("./scripts/rbmq.sh")

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.test_sa.email
    scopes = ["cloud-platform"]
  }
}


