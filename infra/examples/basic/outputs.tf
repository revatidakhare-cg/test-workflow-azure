output "windows_virtual_machine_id" {
  value = module.windows_virtual_machine.virtual_machine_id
  description = "Resource ID of the deployed Windows Virtual Machine."
}

output "app_service_id" {
  value = module.app_service.app_service_id
  description = "Resource ID of the Azure App Service."
}

output "virtual_network_id" {
  value = module.virtual_network.virtual_network_id
  description = "Resource ID of the Azure Virtual Network."
}

output "storage_account_id" {
  value = module.storage_account.storage_account_id
  description = "Resource ID of the Azure Storage Account."
}

output "key_vault_id" {
  value = module.key_vault.key_vault_id
  description = "Resource ID of the Azure Key Vault."
}
