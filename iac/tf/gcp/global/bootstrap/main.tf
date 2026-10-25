terraform {
  required_version = "~> 1.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }

  # initial bootstrap
  backend "local" {
    path = "terraform.tfstate"
  }

  # # move the initial tfstate from local to gcs
  # backend "gcs" {
  #   bucket = "nairvarun"
  #   prefix = "gcp/global/bootstrap"
  # }
}

provider "google" {
  region = var.region

  default_labels = {
    owner      = "nv"
    repo       = "homelab"
    managed-by = "terraform"
    module     = "global-bootstrap"
  }
}
