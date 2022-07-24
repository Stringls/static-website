output "bucket_regional_domain_name" {
  value       = module.bucket.bucket_regional_domain_name
  description = "S3 Bucket REGIONAL domain name"
}

output "cloudfront_domain_name" {
  value       = module.cloudfront.cloudfront_domain_name
  description = "Cloudfront domain name"
}