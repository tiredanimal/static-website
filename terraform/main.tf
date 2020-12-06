provider "azurerm" {
  version = "2.38.0"
  features {}
}

provider "cloudflare" {
  version = "~> 2.0"
}

module "azure" {
  source = "./modules/azure"

  env = var.env
}