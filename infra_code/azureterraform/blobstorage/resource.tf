provider "azurerm" {
  features { }

  subscription_id   = var.subscription_id
  tenant_id         = var.tenant_id
  client_id         = var.client_id
  client_secret     = var.client_secret
}
resource "azurerm_resource_group" "example" {
  name     = var.resource
  location = var.location
}

resource "azurerm_storage_account" "example" {
  name                     = var.storage
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  enable_https_traffic_only = true

  static_website {
    index_document = var.index  # Replace with your preferred index document
    error_404_document = var.error # Replace with your custom 404 error page if needed
  }
  provisioner "local-exec" {
    command = "bash ./script.sh"
  }
}
