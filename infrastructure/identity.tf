resource "azurerm_user_assigned_identity" "aks_workload" {
  name                = "${local.name_prefix}-workload-mi"
  location            = azurerm_resource_group.niv.location
  resource_group_name = azurerm_resource_group.niv.name

  tags = local.tags
}


resource "azurerm_federated_identity_credential" "aks_workload" {
  name                = "${local.name_prefix}-workload-fic"
  resource_group_name = azurerm_resource_group.niv.name
  parent_id           = azurerm_user_assigned_identity.aks_workload.id

  issuer = azurerm_kubernetes_cluster.niv.oidc_issuer_url

  subject = "system:serviceaccount:default:aks-workload"

  audience = [
    "api://AzureADTokenExchange"
  ]
}