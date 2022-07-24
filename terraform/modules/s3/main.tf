##################################

resource "aws_s3_bucket" "main" {
  bucket = "www.${var.bucket_name}.com"

  tags = {
    Name      = "Static WebSite Bucket"
    Env       = var.env
    ManagedBy = "terraform"
    RepoURL   = var.repo_url
  }
}

resource "aws_s3_bucket_acl" "main" {
  bucket = aws_s3_bucket.main.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error/index.html"
  }
}

resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.main.id
  policy = data.aws_iam_policy_document.allow_access_to_everyone.json
}

data "aws_iam_policy_document" "allow_access_to_everyone" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.main.arn}/*",
    ]
  }
}