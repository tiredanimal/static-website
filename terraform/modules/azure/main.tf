locals {
  cloud_name = "azure"

  custom_path     = "${var.name}.${local.cloud_name}.${var.env}"
  custom_full_url = "${local.custom_path}.${var.custom_domain}"

  full_name      = "${var.org_name}${var.env}${var.name}"
  azure_domain   = "z33.web.core.windows.net"
  azure_full_url = "${local.full_name}.${local.azure_domain}"
}

// General
resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
}

// Networking
resource "cloudflare_record" "this" {
  zone_id = "1804341c8b633f83d43dab12a5dfcfb1"
  name    = local.custom_path
  value   = local.azure_full_url
  type    = "CNAME"
  ttl     = 3600
}

// Storage
resource "azurerm_storage_account" "this" {
  name                      = local.full_name
  resource_group_name       = azurerm_resource_group.this.name
  location                  = var.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  enable_https_traffic_only = false

  static_website {
    index_document = "index.html"
  }

  custom_domain {
    name = local.custom_full_url
  }

  depends_on = [cloudflare_record.this]
}

resource "azurerm_storage_blob" "this" {
  for_each               = fileset("../src/", "**")
  name                   = each.value
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "../src/${each.value}"
  content_type           = "text/html"
  content_md5            = filemd5("../src/${each.value}")
}
