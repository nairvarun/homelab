output "state_bucket_arn" {
  description = "S3 bucket ARN for Terraform state"
  value       = aws_s3_bucket.tf_state.arn
}

output "state_bucket_name" {
  description = "S3 bucket name for Terraform state"
  value       = aws_s3_bucket.tf_state.id
}

output "dynamodb_table_arn" {
  description = "DynamoDB table ARN for state locking"
  value       = var.enable_state_locking ? aws_dynamodb_table.tf_lock[0].arn : null
}

output "dynamodb_table_name" {
  description = "DynamoDB table name for state locking"
  value       = var.enable_state_locking ? aws_dynamodb_table.tf_lock[0].name : null
}
