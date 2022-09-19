provider "google" {
  
}


resource "google_compute_instance" "web" {
  
  project = "nomadic-oarlock-362811"
  name = "web"
  machine_type = "n1-standard-4"
  zone = "us-central1-a"


  tags = ["allow-80"]
  boot_disk {
    initialize_params{
        image = "centos-cloud/centos-7"
    }
  }
  metadata_startup_script =  file("jenkins.sh")
  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }

  }
}

resource "google_compute_instance" "app" {
  
  project = "nomadic-oarlock-362811"
  name = "app"
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