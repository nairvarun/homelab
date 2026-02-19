provider "aws" {
  region  = var.region
  profile = var.profile

  default_tags {
    tags = {
      Owner       = "nv"
      Repo        = "homelab"
      ManagedBy   = "terraform"
      Module      = "bootstrap"
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
