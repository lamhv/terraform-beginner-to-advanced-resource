terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.27.0"
    }
  }
}

provider "google" {
  project = "fb-crawler-331309"
  zone = "asia-southeast1-a"
  region = "asia-southeast1"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.subnetwork.self_link
    network_ip = google_compute_address.internal_with_subnet_and_address.id
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "false"
}

resource "google_compute_address" "static" {
  name = "ipv4-address"
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "my-subnet"
  ip_cidr_range = "10.0.0.0/16"
  region = "asia-southeast1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_address" "internal_with_subnet_and_address" {
  name         = "my-internal-address"
  subnetwork   = google_compute_subnetwork.subnetwork.id
  address_type = "INTERNAL"
  address      = "10.0.42.42"
  region = "asia-southeast1"
}