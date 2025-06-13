terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

data "google_client_config" "default" {}

data "google_project" "project" {}

provider "google" {
  project = var.gcp_project_id
}