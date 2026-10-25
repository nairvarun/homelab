# service account terraform runs as, via impersonation (no keys)
resource "google_service_account" "terraform" {
  project      = google_project.admin.project_id
  account_id   = "terraform"
  display_name = "Terraform"

  depends_on = [google_project_service.admin]
}

resource "google_service_account_iam_member" "terraform_token_creator" {
  service_account_id = google_service_account.terraform.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "user:${var.admin_email}"
}

resource "google_storage_bucket_iam_member" "terraform_state" {
  bucket = google_storage_bucket.tf_state.name
  role   = "roles/storage.objectAdmin"
  member = google_service_account.terraform.member
}

resource "google_billing_account_iam_member" "terraform_billing_user" {
  billing_account_id = var.billing_account
  role               = "roles/billing.user"
  member             = google_service_account.terraform.member
}
