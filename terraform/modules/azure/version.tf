terraform {
  required_version = ">= 0.12.16"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.38.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 2.0"
    }
  }
}
