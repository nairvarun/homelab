# admin project: holds tf state and the terraform service account, nothing else
resource "google_project" "admin" {
  name            = var.project_id
  project_id      = var.project_id
  billing_account = var.billing_account

  deletion_policy = "PREVENT"
}

resource "google_project_service" "admin" {
  for_each = toset([
    "billingbudgets.googleapis.com",
    "cloudbilling.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "serviceusage.googleapis.com",
    "storage.googleapis.com",
  ])

  project            = google_project.admin.project_id
  service            = each.value
  disable_on_destroy = false
}
