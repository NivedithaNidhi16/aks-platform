resource "random_string" "acr_suffix" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_container_registry" "niv" {
  name                = "nivacr${random_string.acr_suffix.result}"
  resource_group_name = azurerm_resource_group.niv.name
  location            = azurerm_resource_group.niv.location
  sku                 = "Basic"
  admin_enabled       = false
}