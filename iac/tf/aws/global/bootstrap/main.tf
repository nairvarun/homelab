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

  # # initial bootstrap
  # backend "local" {
  #   path = "terraform.tfstate"
  # }

  # move the initial tfstate from local to s3 
  backend "s3" {
    bucket         = "homelab-tf-state-9bb31731"
    key            = "aws/global/bootstrap/terraform.tfstate"
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
      Module      = "global/bootstrap"
    }
  }
}

# s3
module "name_s3_bucket" {
  source = "../../modules/naming"
  purpose = "tf-state"
}

resource "aws_s3_bucket" "tf_state" {
  bucket = module.name_s3_bucket.unique_name
}

resource "aws_s3_bucket_versioning" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "tf_state" {
  bucket                  = aws_s3_bucket.tf_state.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

# dynamodb
module "name_dynamodb_table" {
  source = "../../modules/naming"
  purpose = "tf_lock"
}

resource "aws_dynamodb_table" "tf_lock" {
  count        = var.enable_state_locking ? 1 : 0
  name         = module.name_dynamodb_table.name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
