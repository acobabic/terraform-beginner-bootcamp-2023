output "website_bucket_name" {
  description = "Bucket name for our static website hosting"
  value = aws_s3_bucket.website_bucket.bucket
}

output "website_endpoint" {
  description = "URL of our statically hosted website"
  value = aws_s3_bucket_website_configuration.website_configuration.website_endpoint
}

output "s3_distribution_domain_name" {
  description = "Domain name of our CloudFront Distribution used for our statically hosted website"
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}

