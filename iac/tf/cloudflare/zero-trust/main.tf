terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.17"
    }
  }

  backend "s3" {
    bucket         = "homelab-tf-state-9bb31731"
    key            = "cloudflare/zero-trust/terraform.tfstate"
    profile        = "nv"
    region         = "ap-south-1"
    dynamodb_table = "homelab-tf_lock"
    encrypt        = true
  }
}

provider "cloudflare" {
  api_key = var.cloudflare_api_key
  email = "nairvarun104@gmail.com"
}

locals {
  account_id = "43fdc05cb8ad9e08e7688dfc3be006fc"
}
