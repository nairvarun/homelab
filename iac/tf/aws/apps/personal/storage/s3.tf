import {
  to = aws_s3_bucket.nairvarun
  id = "nairvarun"
}

resource "aws_s3_bucket" "nairvarun" {
  bucket = "nairvarun"

  lifecycle {
    prevent_destroy = true
  }
}
