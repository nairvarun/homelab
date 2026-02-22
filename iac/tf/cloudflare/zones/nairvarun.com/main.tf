terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.17"
    }
  }

  backend "s3" {
    bucket         = "homelab-tf-state-9bb31731"
    key            = "cloudflare/zones/nairvarun.com/terraform.tfstate"
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

# # known bug in v5 where this is taking too long to fetch
# # hardcoding the value for now
# data "cloudflare_accounts" "nairvarun" {
#   name = "nairvarun"
# }

data "cloudflare_zone" "nairvarun_com" {
  filter = {
    name = "nairvarun.com"
  }
}

data "terraform_remote_state" "zero_trust" {
  backend = "s3"
  config = {
    bucket  = "homelab-tf-state-9bb31731"
    key     = "cloudflare/zero-trust/terraform.tfstate"
    region  = "ap-south-1"
  }
}

locals {
  account_id = "43fdc05cb8ad9e08e7688dfc3be006fc"
  zone_id = data.cloudflare_zone.nairvarun_com.id
  tunnel_id = data.terraform_remote_state.zero_trust.outputs.tunnel_id
}
