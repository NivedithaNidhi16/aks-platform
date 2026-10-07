terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.8.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.7"
    }
  }
  required_version = ">=1.9.0"
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription
  tenant_id       = var.tenant
}
