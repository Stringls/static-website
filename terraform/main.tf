terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.23.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  # Configuration options
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  region     = var.AWS_REGION
}

######################
# tags locals

locals {
  env      = "Prod"
  repo_url = "https://github.com/Stringls/static-website"
}

###################
# random

resource "random_string" "main" {
  length  = 4
  upper   = false
  special = false
}

#####################################
# S3 BUCKET
#####################################

module "bucket" {
  source = "./modules/s3"

  # tags
  env      = local.env
  repo_url = local.repo_url

  bucket_name = random_string.main.result
}

#####################################
# CLOUDFRONT
#####################################

module "cloudfront" {
  source = "./modules/cloudfront"

  # tags
  env      = local.env
  repo_url = local.repo_url

  bucket_website_endpoint        = module.bucket.bucket_website_endpoint
  main_origin_id                 = module.bucket.bucket_name
  custom_origin_protocol_policy  = "https-only"
  enable_main_cloudfront         = true
  is_ipv6_enabled                = true
  default_query_string           = false
  default_headers                = []
  default_cookies                = "none"
  main_min_ttl                   = 0
  main_max_ttl                   = 31536000
  main_default_ttl               = 86400
  default_cache_compress         = true
  default_viewer_protocol_policy = "redirect-to-https"
  cloudfront_default_certificate = true

  depends_on = [
    module.bucket
  ]
}

# resource "aws_cloudfront_distribution" "distribution" {
#   origin {
#     domain_name = "unknown"
#     origin_id = "unknown"
#   }

#   enabled = true

#   default_cache_behavior {
#     allowed_methods = []
#     cached_methods = []
#     target_origin_id = "unknown"

#     forwarded_values {
#       query_string = false

#       cookies {
#         forward = "none"
#       }
#     }

#     viewer_protocol_policy = "unknown"
#   }

#   restrictions {
#     geo_restriction {
#       restriction_type = "unknown"
#     }
#   }

#   viewer_certificate {
#     cloudfront_default_certificate = "unknown"
#   }
# }