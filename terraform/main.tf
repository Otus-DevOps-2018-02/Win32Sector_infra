provider "google" {
  version = "1.4"
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "europe-west1-b"
  tags         = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key)}"

  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }

  metadata {
    ssh-keys = "appuser:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDeFchCwDoJCEzRkE8/QbmqzY8B9I79B+PdytxfgGwOBvYmXcm0JSDh/gvG2ORZGb7LOrsLz4p4MSjLVVokO5DLuHY8Iq3VAQGc4bd7HDSGbVfHv9E+l0s33WC+nrMOkft7icZemiKDR7iYkTujxJg6NDcTQ41ivTZai6fLCU6UcbGP/O3bCd51k/vWfAS5xU9VP6uJWDi4UrAx4/I8EyoCj5VPyriQpt3uIkHFBNgFiVQD/RrSHBcfaXnTXscsAwfWWf5BkAlIkIE/i4AXgPgY+Nml9PbdWSFgDmCeYXwTP1eVpF/MKpefRYWSSAiRDcVNykv9im2JM/zvcv0C6nBh appuser1"
  }

  network_interface {
    network       = "default"
    access_config = {}
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}

resource "google_compute_project_metadata_item" "keys" {
    project = "${var.project}"
    key = "ssh-keys"
    value = "${file(var.public_keys)}"
}
