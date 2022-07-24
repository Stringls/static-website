terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.23.0"
    }
  }
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

  bucket_regional_domain_name    = module.bucket.bucket_website_endpoint
  main_origin_id                 = random_string.main.result
  custom_origin_protocol_policy  = "https-only"
  enable_main_cloudfront         = true
  default_query_string           = false
  default_headers                = []
  default_cookies                = "none"
  main_min_ttl                   = 0
  main_max_ttl                   = 31536000
  main_default_ttl               = 86400
  default_cache_compress         = true
  default_viewer_protocol_policy = "allow-all"
  cloudfront_default_certificate = true
}