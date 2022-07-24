output "bucket_regional_domain_name" {
  value       = aws_s3_bucket.main.website_endpoint
  description = "Output s3 bucket regional domain name"
}