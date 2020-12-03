resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
}

resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = azurerm_resource_group.this.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
      index_document = "index.html"
  }
}

