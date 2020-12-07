locals {
  org_name   = "tiredanimal"
  cloud_name = "aws"

  custom_domain   = "${local.org_name}.com"
  custom_path     = "${var.name}.${local.cloud_name}.${var.env}"
  custom_full_url = "${local.custom_path}.${local.custom_domain}"

  full_name      = "${local.org_name}${var.env}${var.name}"
  aws_domain   = "s3-website.eu-west-2.amazonaws.com"
  aws_full_url = "${local.full_name}.${local.aws_domain}"
}

// Networking
resource "cloudflare_record" "this" {
  zone_id = "1804341c8b633f83d43dab12a5dfcfb1"
  name    = local.custom_path
  value   = local.aws_full_url
  type    = "CNAME"
  ttl     = 3600
}

// Storage
resource "aws_s3_bucket" "this" {
  bucket = local.full_name
  acl    = "public-read"

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_object" "this" {
  bucket = aws_s3_bucket.this.id
  key    = "index.html"
  source = "../src/index.html"

  etag = filemd5("../src/index.html")
}
