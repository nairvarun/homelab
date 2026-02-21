terraform {
  required_version = "~> 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.33"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 3.5"
    }
  }

  backend "s3" {
    bucket         = "homelab-tf-state-85c020c7"
    key            = "global/governance/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "homelab-tf_lock"
    encrypt        = true
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile

  default_tags {
    tags = {
      Owner       = "nv"
      Repo        = "homelab"
      ManagedBy   = "terraform"
      Module      = "governance"
    }
  }
}
