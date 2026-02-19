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

variable "enable_state_locking" {
  description = "Whether to create DynamoDB table for state locking"
  type        = bool
  default     = true
}
