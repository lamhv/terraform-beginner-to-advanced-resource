terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.64.0"
    }
  }
}

provider "google" {
  project = "data-engineering-230006"
  zone = "asia-southeast1-a"
  region = "asia-southeast1"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.subnetwork.self_link
    network_ip = google_compute_address.internal_with_subnet_and_address.id

    # attach IP to instance
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

}

# Create a VPC network with disabled subnet creation
resource "google_compute_network" "vpc_network" {
  name                    = "lamhoang-terraform-network"
  auto_create_subnetworks = "false"
}

# Create static IP address
resource "google_compute_address" "static" {
  name = "ipv4-address"
}

# Create a subnet
resource "google_compute_subnetwork" "subnetwork" {
  name          = "lamhoang-my-subnet"
  ip_cidr_range = var.subnet_range_ip
  region = "asia-southeast1"
  network       = google_compute_network.vpc_network.id
}

# Create an internal IP address
resource "google_compute_address" "internal_with_subnet_and_address" {
  name         = "lamhoang-my-internal-address"
  subnetwork   = google_compute_subnetwork.subnetwork.id
  address_type = "INTERNAL"
  address      = var.private_ip
  region = "asia-southeast1"
}

# create firewall rule
resource "google_compute_firewall" "default" {
  name    = "lamhoang-firewall"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = var.range_ports
  }

  source_ranges = [google_compute_subnetwork.subnetwork.ip_cidr_range]
}

output "eip" {
  value = google_compute_address.static.address
}

output "xxx" {
  value = google_compute_address.internal_with_subnet_and_address.id
}

output "yyy" {
  value = google_compute_address.internal_with_subnet_and_address
}