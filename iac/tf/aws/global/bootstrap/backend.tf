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

  backend "local" {
    path = "terraform.tfstate"
  }
}
