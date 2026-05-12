output "id" {
  description = "The ID of the storage account."
  value       = azurerm_storage_account.main.id
}

output "name" {
  description = "The name of the storage account."
  value       = azurerm_storage_account.main.name
}

output "primary_blob_endpoint" {
  description = "Primary blob endpoint of the storage account."
  value       = azurerm_storage_account.main.primary_blob_endpoint
}

output "primary_access_key" {
  description = "Primary access key for the storage account. Sensitive and should be stored in Key Vault."
  value       = azurerm_storage_account.main.primary_access_key
  sensitive   = true
}
