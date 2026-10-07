resource "azurerm_kubernetes_cluster" "niv" {
  name                = "${local.name_prefix}-aks"
  location            = azurerm_resource_group.niv.location
  resource_group_name = azurerm_resource_group.niv.name
  dns_prefix          = "${local.name_prefix}-dns"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.niv.id
  }

  tags = local.tags
}

