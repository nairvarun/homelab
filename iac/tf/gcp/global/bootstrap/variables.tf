variable "billing_account" {
  description = "Billing account ID (gcloud billing accounts list)"
  type        = string
}

variable "project_id" {
  description = "Globally unique ID for the admin project"
  type        = string
  default     = "nv-homelab-admin"
}

variable "region" {
  description = "Default region"
  type        = string
  default     = "asia-south1"
}

variable "state_bucket_name" {
  description = "Globally unique name for the tf state bucket"
  type        = string
  default     = "nairvarun"
}

variable "admin_email" {
  description = "Google account allowed to impersonate the terraform service account"
  type        = string
  default     = "nairvarun104@gmail.com"
}
