terraform {
  required_version = ">= 0.12.16"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.2.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 2.0"
    }
  }
}
