output "website_bucket_name" {
  description = "Bucket name for our static website hosting"
  value = aws_s3_bucket.website_bucket.bucket
}

output "website_endpoint" {
  description = "URL of our staticly hosted website"
  value = aws_s3_bucket_website_configuration.website_configuration.website_endpoint
}
