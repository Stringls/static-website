output "bucket_website_endpoint" {
  value       = aws_s3_bucket.main.website_endpoint
  description = "Output s3 bucket website endpoint"
}