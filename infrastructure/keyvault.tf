data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "niv" {
  name                = "${local.name_prefix}-kv"
  location            = azurerm_resource_group.niv.location
  resource_group_name = azurerm_resource_group.niv.name

  tenant_id = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  enable_rbac_authorization = true

  tags = local.tags
}