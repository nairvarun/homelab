# s3 bucket for aws config
module "config_bucket_name" {
  source = "../../modules/naming"
  purpose = "config-bucket"
}

resource "aws_s3_bucket" "config_bucket" {
  bucket = module.config_bucket_name.unique_name
  force_destroy = true
}

# iam role for aws config
module "config_role_name" {
  source = "../../modules/naming"
  purpose = "config_role"
}

resource "aws_iam_role" "config_role" {
  name = module.config_role_name.name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "config.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "config_role_policy_attachment" {
  role       = aws_iam_role.config_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
}

module "config_role_s3_policy_name" {
  source = "../../modules/naming"
  purpose = "config_role_s3_policy"
}

resource "aws_iam_role_policy" "config_role_s3_policy" {
  name = module.config_role_s3_policy_name.name
  role = aws_iam_role.config_role.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["s3:PutObject"]
      Resource = "${aws_s3_bucket.config_bucket.arn}/AWSLogs/*"
    }]
  })
}

# set up aws config
module "config_recorder_name" {
  source = "../../modules/naming"
  purpose = "config_recorder"
}

resource "aws_config_configuration_recorder" "config_recorder" {
  name     = module.config_recorder_name.name
  role_arn = aws_iam_role.config_role.arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

resource "aws_config_configuration_recorder_status" "config_recorder_status" {
  name       = aws_config_configuration_recorder.config_recorder.name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.config_delivery_channel]
}

module "config_delivery_channel_name" {
  source = "../../modules/naming"
  purpose = "aws_config"
}

resource "aws_config_delivery_channel" "config_delivery_channel" {
  name           = module.config_delivery_channel_name.name
  s3_bucket_name = aws_s3_bucket.config_bucket.id
  depends_on     = [aws_config_configuration_recorder.config_recorder]
}

# config rule to enforce tags
module "required_tags_config_rule_name" {
  source = "../../modules/naming"
  purpose = "required_tags"
}
resource "aws_config_config_rule" "required_tags" {
  name = module.required_tags_config_rule_name.name

  source {
    owner             = "AWS"
    source_identifier = "REQUIRED_TAGS"
  }

  input_parameters = jsonencode({
    tag1Key = "Owner"
    tag2Key = "Repo"
    tag3Key = "ManagedBy"
    tag4Key = "Module"
  })

  depends_on = [aws_config_configuration_recorder.config_recorder]
}
