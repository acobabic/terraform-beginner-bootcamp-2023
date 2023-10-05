output "bucket_name" {
  description = "Bucket name for our static website hosting"
  value       = module.home_half_life_hosting.website_bucket_name
}

output "s3_website_endpoint" {
  description = "S3 static website hosting endpoint"
  value       = module.home_half_life_hosting.website_endpoint
}

output "s3_distribution_domain_name" {
  description = "Domain name of our CloudFront Distribution used for our statically hosted website"
  value       = module.home_half_life_hosting.s3_distribution_domain_name
}