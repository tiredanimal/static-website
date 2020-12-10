terraform {
  required_version = ">= 0.13"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.39.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.14.0"
    }
  }
}
