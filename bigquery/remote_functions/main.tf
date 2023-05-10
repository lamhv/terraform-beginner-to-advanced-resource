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

resource "google_bigquery_connection" "connection" {
  connection_id = "lamhoang-connection"
  project = "data-engineering-230006"
  location = "asia-southeast1"
  cloud_resource {}
}