provider "azurerm" {
  version = "=2.20.0"
  features {}
}

module "azure" {
    source = "./modules/azure"
}