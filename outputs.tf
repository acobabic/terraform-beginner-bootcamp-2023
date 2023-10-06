output "half_life_bucket_name" {
  description = "Bucket name for our static website hosting"
  value       = module.home_half_life_hosting.website_bucket_name
}

output "half_life_s3_website_endpoint" {
  description = "S3 static website hosting endpoint"
  value       = module.home_half_life_hosting.website_endpoint
}

output "half_life_domain_name" {
  description = "Domain name of our CloudFront Distribution used for our statically hosted website"
  value       = module.home_half_life_hosting.s3_distribution_domain_name
}

output "bl_cevap_bucket_name" {
  description = "Bucket name for our static website hosting"
  value       = module.home_bl_cevap_hosting.website_bucket_name
}

output "bl_cevap_s3_website_endpoint" {
  description = "S3 static website hosting endpoint"
  value       = module.home_bl_cevap_hosting.website_endpoint
}

output "bl_cevap_domain_name" {
  description = "Domain name of our CloudFront Distribution used for our statically hosted website"
  value       = module.home_bl_cevap_hosting.s3_distribution_domain_name
}