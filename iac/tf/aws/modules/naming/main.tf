variable "project" {
  default = "homelab"
}

variable "purpose" {}

resource "random_id" "suffix" {
  byte_length = 4
}

output "name" {
  value = "${var.project}-${var.purpose}"
}

output "unique_name" {
  value = "${var.project}-${var.purpose}-${random_id.suffix.hex}"
}
