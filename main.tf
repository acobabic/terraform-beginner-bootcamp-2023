resource "random_string" "bucket_name" {
  length  = 16
  special = false
  lower   = true
  upper   = false
}

resource "aws_s3_bucket" "bucket_name" {
  bucket = random_string.bucket_name.result

  tags = {
    UserUuid        = var.user_uuid
    Environment     = var.environment
  }
}
