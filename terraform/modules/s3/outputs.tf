output "bucket_website_endpoint" {
  value       = aws_s3_bucket.main.website_endpoint
  description = "Output s3 bucket website endpoint"
}

output "bucket_name" {
  value = aws_s3_bucket.main.bucket
  description = "S3 Bucket name"
}