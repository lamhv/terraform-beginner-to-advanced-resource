terraform {
  backend "gcs" {
    bucket  = "data-engineering-230006-lamhoang-data-storage-bucket"
    prefix  = "terraform/hdp-state"  # Optional: folder within the bucket to store state
  }
}

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

# 2. Networking: Create a VPC network and a subnet.
# resource "google_compute_network" "hdp-network" {
#   name                    = "dp-sim-network"
#   auto_create_subnetworks = false
# }

data "google_compute_network" "hdp-network" {
  name                    = "dp-sim-network"
}

# resource "google_compute_subnetwork" "hdp-subnet" {
#   name          = "hdp-subnet"
#   ip_cidr_range = var.subnet_range_ip
#   network       = google_compute_network.hdp-network.id
#   region        = "asia-southeast1"
# }

data "google_compute_subnetwork" "hdp-subnet" {
  name   = "dp-sim-private-1"
  region = "asia-southeast1"
}

# 3. Firewall Rules: Allow internal communication between nodes.
# resource "google_compute_firewall" "hdp-internal" {
#   name    = "hdp-allow-internal"
#   network = data.google_compute_network.hdp-network.name
#
#   allow {
#     protocol = "tcp"
#     ports    = ["0-65535"]
#   }
#
#   source_ranges = [var.subnet_range_ip]
# }
# 4. Compute Instances: Create 3 VM instances for the HDP nodes.
resource "google_compute_instance" "hdp-node" {
  count        = 3
  name         = "hdp-node-${count.index + 1}"
  machine_type = "n1-standard-8"
  zone         = "asia-southeast1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11" # Choose a suitable image for HDP
      size  = 100 # Set the boot disk size to 100GB
    }
  }

  network_interface {
    network    = data.google_compute_network.hdp-network.id
    subnetwork = data.google_compute_subnetwork.hdp-subnet.id
    // No access_config block means no external IP will be assigned
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y openjdk-8-jdk
    # Additional setup for HDP can be added here
  EOT
}