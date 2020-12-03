provider "azurerm" {
  version = "2.38.0"
  features {}
}

module "azure" {
    source = "./modules/azure"
}