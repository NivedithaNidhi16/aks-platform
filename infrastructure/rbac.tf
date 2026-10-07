resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id         = azurerm_kubernetes_cluster.niv.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.niv.id
}

resource "azurerm_role_assignment" "workload_keyvault_secrets_user" {
  principal_id         = azurerm_user_assigned_identity.aks_workload.principal_id
  role_definition_name = "Key Vault Secrets User"
  scope                = azurerm_key_vault.niv.id
}