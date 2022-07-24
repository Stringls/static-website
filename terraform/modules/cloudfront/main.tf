resource "aws_cloudfront_distribution" "main" {
  origin {
    domain_name = var.bucket_regional_domain_name
    origin_id   = var.main_origin_id

    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = var.custom_origin_protocol_policy
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  enabled = var.enable_main_cloudfront ? true : false

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.main_origin_id

    forwarded_values {
      query_string = var.default_query_string ? true : false
      headers      = var.default_headers

      cookies {
        forward = var.default_cookies
      }
    }

    min_ttl                = var.main_min_ttl
    default_ttl            = var.main_default_ttl
    max_ttl                = var.main_max_ttl
    compress               = var.default_cache_compress ? true : false
    viewer_protocol_policy = var.default_viewer_protocol_policy
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name      = "Main distribution"
    Env       = var.env
    ManagedBy = "terraform"
    RepoURL   = var.repo_url
  }

  viewer_certificate {
    cloudfront_default_certificate = var.cloudfront_default_certificate ? true : false
  }
}