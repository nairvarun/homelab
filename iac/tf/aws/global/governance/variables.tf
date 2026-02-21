variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "profile" {
  description = "AWS CLI profile to use"
  type        = string
  default     = "nv"
}

variable "monthly_budget_usd" {
  description = "Monthly budget limit in USD"
  type        = number
  default     = 10
}

variable "budget_alert_email" {
  description = "Email to receive budget alerts"
  type        = string
  default     = "nairvarun104@gmail.com"
}
