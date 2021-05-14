locals {
  cloud_name = "google"

  custom_path     = "${var.name}.${local.cloud_name}.${var.env}"
  custom_full_url = "${local.custom_path}.${var.custom_domain}"

  google_domain   = "s3-website.eu-west-2.amazonaws.com"
  google_full_url = "${local.custom_full_url}.${local.google_domain}"
}

// Networking
resource "cloudflare_record" "this" {
  zone_id = "1804341c8b633f83d43dab12a5dfcfb1"
  name    = local.custom_path
  value   = local.google_full_url
  type    = "CNAME"
  ttl     = 3600
}

// Storage
resource "google_storage_bucket" "this" {
  name          = local.custom_full_url
  location      = "EU"
  force_destroy = true

  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
  }
}
