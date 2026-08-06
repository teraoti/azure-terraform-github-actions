output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "rg-github-actions-demo"
}

output "storage_account_name" {
  value       = azurerm_storage_account.st.name # Replace with your exact storage resource block name if different
  description = "stiacdemo001"
}
"
}

