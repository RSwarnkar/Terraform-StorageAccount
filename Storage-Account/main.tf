
# Default provider
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
}

 
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.73.0"
    }
  }
}
 


# Create Resource Group
resource "azurerm_resource_group" "resource_group" {
  name     = "rsw-alzd-p-cin-rsg-devops"
  location = "centralindia"
  tags     = {
    Source = "RSwarnkar/Terraform-StorageAccount"
    CreatedBy = "Github-Actions"
  }
}

# Create Storage Account 

resource "azurerm_storage_account" "sa" {
  name                     = "rswdevopstfstore"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = "centralindia"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  access_tier              = "Hot"
  min_tls_version          = "TLS1_2"
  https_traffic_only_enabled = true
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = true
  public_network_access_enabled   = true
  
  depends_on = [ 
    azurerm_resource_group.resource_group
   ]  
}

resource "azurerm_storage_container" "sa_container" {
  name                  = "subscriptions"
  storage_account_id    = azurerm_storage_account.sa.id
  container_access_type = "private"
}

 