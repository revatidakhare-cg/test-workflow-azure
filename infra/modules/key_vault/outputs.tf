# Key Vault module: outputs.tf
output "key_vault_id" {
  description = "The ID of the Key Vault."
  value       = azurerm_key_vault.this.id
}

output "key_vault_name" {
  description = "The name of the Key Vault."
  value       = azurerm_key_vault.this.name
}

output "key_vault_uri" {
  description = "The URI endpoint for accessing the Key Vault."
  value       = azurerm_key_vault.this.vault_uri
}

output "admin_password_secret_id" {
  description = "ID of the admin password Key Vault secret."
  value       = azurerm_key_vault_secret.admin_password.id
  sensitive   = true
}
