output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "The verified resource group name on Azure."
}

output "storage_account_name" {
  value       = azurerm_storage_account.st.name # Replace with your exact storage resource block name if different
  description = "The name of your deployed storage account."
}

