resource "google_compute_instance" "loadbalancer" {
  name         = "loadbalancer-instance"
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

  metadata_startup_script = file("./scripts/loadbalancer.sh")

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.test_sa.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "master1" {
  name         = "master1-instance"
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

  metadata_startup_script = file("./scripts/master.sh")

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

  metadata_startup_script = file("./scripts/master.sh")

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

  metadata_startup_script = file("./scripts/worker.sh")

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

  metadata_startup_script = file("./scripts/master.sh")

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.test_sa.email
    scopes = ["cloud-platform"]
  }
}


