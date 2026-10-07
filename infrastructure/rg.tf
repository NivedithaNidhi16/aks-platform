resource "azurerm_resource_group" "niv" {
  name     = "${local.name_prefix}-rg"
  location = var.location

  tags = local.tags
}
