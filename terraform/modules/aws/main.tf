locals {
  cloud_name = "aws"

  custom_path     = "${var.name}.${local.cloud_name}.${var.env}"
  custom_full_url = "${local.custom_path}.${var.custom_domain}"

  aws_domain   = "s3-website.eu-west-2.amazonaws.com"
  aws_full_url = "${local.custom_full_url}.${local.aws_domain}"
}

// Networking
resource "cloudflare_record" "this" {
  zone_id = "1804341c8b633f83d43dab12a5dfcfb1"
  name    = local.custom_path
  value   = local.aws_full_url
  type    = "CNAME"
  ttl     = 3600
}

data "aws_iam_policy_document" "this" {
  statement {
    sid = "Publicread"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "arn:aws:s3:::${local.custom_full_url}/*",
    ]
  }
}

// Storage
resource "aws_s3_bucket" "this" {
  bucket = local.custom_full_url
  acl    = "public-read"
  policy = data.aws_iam_policy_document.this.json

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_object" "this" {
  for_each     = fileset("../src/", "**")
  bucket       = aws_s3_bucket.this.id
  key          = each.value
  source       = "../src/${each.value}"
  content_type = "text/html"

  etag = filemd5("../src/${each.value}")
}
