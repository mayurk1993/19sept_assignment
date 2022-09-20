provider "google" {
  
}

resource "google_compute_instance" "app" {
  
  project = "nomadic-oarlock-362811"
  name = "web"
  machine_type = "n1-standard-4"
  zone = "us-central1-a"


  tags = ["allow-80", "allow-8080"]
  boot_disk {
    initialize_params{
        image = "centos-cloud/centos-7"
    }
  }
  metadata_startup_script =  file("jenkins.sh")
  network_interface {
    network = "default"


  }
}

resource "google_compute_instance" "db" {
  
  project = "nomadic-oarlock-362811"
  name = "db"
  machine_type = "n1-standard-4"
  zone = "us-central1-a"

  boot_disk {
    initialize_params{
        image = "centos-cloud/centos-7"
    }
  }

  network_interface {
    network = "default"


  }
}


resource "google_compute_instance_group" "webservers" {
  name        = "jnk-ig"
  project = "nomadic-oarlock-362811"
  instances = [
    google_compute_instance.app.id
  ]

  zone = "us-central1-a"
}


resource "google_compute_region_health_check" "tcp-region-health-check" {
  name     = "tcp-region-health-check"
  project = "nomadic-oarlock-362811"
  region = "us-central1"
  timeout_sec        = 1
  check_interval_sec = 1

  tcp_health_check {
    port = "80"
  }
}

resource "google_compute_region_backend_service" "default" {
  project = "nomadic-oarlock-362811"
  network = "default"
  name                            = "region-service"
  region                          = "us-central1"
  health_checks                   = [google_compute_region_health_check.tcp-region-health-check.id]
  connection_draining_timeout_sec = 10
  backend {
    group = google_compute_instance_group.webservers.id
  }
}


resource "google_compute_forwarding_rule" "google_compute_forwarding_rule" {
  name                  = "l7-ilb-forwarding-rule"
  region                = "us-central1"
  project = "nomadic-oarlock-362811"
  network = "default"
  ip_protocol           = "TCP"
  load_balancing_scheme = "INTERNAL"
  backend_service = google_compute_region_backend_service.default.id
  ports = ["8080"]
}

