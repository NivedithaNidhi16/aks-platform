terraform {
  backend "azurerm" {
    resource_group_name  = "niv-sa-rg"
    storage_account_name = "nivsatfstate"
    container_name       = "tfstate"
    key                  = "aks.tfstate"
  }
}

    