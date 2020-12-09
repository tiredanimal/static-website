provider "cloudflare" {
  version = "~> 2.0"
}

provider "azurerm" {
  version = "2.38.0"
  features {}
}

provider "aws" {
  version = "3.2.0"
  region = "eu-west-2"
}
