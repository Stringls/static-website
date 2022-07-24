variable "bucket_website_endpoint" {
  type        = string
  description = "S3 bucket website endpoint"
}

variable "main_origin_id" {
  type        = string
  description = "Origin name"
}

variable "custom_origin_protocol_policy" {
  type = string
  description = "The origin protocol policy to apply to your origin. One of [http-only, https-only, match-viewer]"
}

variable "enable_main_cloudfront" {
  type        = bool
  description = "Whether the distribution is enabled to accept end user requests for content"
}

variable "default_query_string" {
  type        = bool
  description = "Query string forwarding for a default origin"
}

variable "default_headers" {
  type        = list(string)
  description = "Forward headers for a default origin"
}

variable "default_cookies" {
  type        = string
  description = "Cookies forwarding for a default origin"
}

variable "main_min_ttl" {
  type        = number
  description = "Minimum time to live in seconds"
}

variable "main_max_ttl" {
  type        = number
  description = "Maximum time to live in seconds"
}

variable "main_default_ttl" {
  type        = number
  description = "Default time to live (one day) in seconds"
}

variable "default_cache_compress" {
  type        = bool
  description = "Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header"
}

variable "default_viewer_protocol_policy" {
  type        = string
  description = "Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https"
}

variable "cloudfront_default_certificate" {
  type        = string
  description = "True if you want viewers to use HTTPS to request your objects and you're using the CloudFront domain name for your distribution."
}

######################
# tags vars

variable "repo_url" {
  type        = string
  description = "Repository URL"
}

variable "env" {
  type        = string
  description = "Project environment"
}