output "project_id" {
  description = "Admin project ID"
  value       = google_project.admin.project_id
}

output "state_bucket_name" {
  description = "GCS bucket name for Terraform state"
  value       = google_storage_bucket.tf_state.name
}

output "terraform_service_account_email" {
  description = "Service account to impersonate from other stacks"
  value       = google_service_account.terraform.email
}
