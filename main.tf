terraform {
  required_version = ">=1.7.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm",
      version = "3.91.0"
    }
  }
}

provider "azurerm" {
  features {

  }
  skip_provider_registration = true
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

}

locals {
  tags = {
    "Environemt" : var.env
  }
}
resource "azurerm_storage_account" "storage" {
  name                          = var.storage_name
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  account_tier                  = "Standard"
  account_replication_type      = var.env == "Producion" ? "GRS" : "LRS"
  tags                          = local.tags
  public_network_access_enabled = false
}
