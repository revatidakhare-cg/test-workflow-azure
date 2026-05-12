# outputs.tf
# SINGLE-SOURCE-OF-TRUTH FOR OUTPUTS: Only defined here, outputs are globally unique.

output "windows_vm_id" {
  description = "The unique ID of the Windows Virtual Machine."
  value       = module.windows_vm.vm_id
}

output "windows_vm_name" {
  description = "The name of the Windows Virtual Machine."
  value       = module.windows_vm.vm_name
}

output "windows_vm_private_ip" {
  description = "The private IP address assigned to the Windows VM."
  value       = module.windows_vm.vm_private_ip
}

output "windows_vm_admin_username" {
  description = "The admin username for the Windows VM."
  value       = module.windows_vm.vm_admin_username
}

output "windows_vm_nic_id" {
  description = "The NIC resource ID for the Windows VM."
  value       = module.windows_vm.vm_nic_id
}

output "resource_group_name" {
  description = "The name of the resource group used for all resources."
  value       = module.resource_group.name
}

output "app_service_id" {
  description = "The App Service resource ID."
  value       = module.app_service.app_service_id
}

output "storage_account_id" {
  description = "The Storage Account resource ID."
  value       = module.storage_account.id
}

output "storage_account_name" {
  description = "The Storage Account name used."
  value       = module.storage_account.name
}

output "key_vault_id" {
  description = "The Key Vault resource ID."
  value       = module.key_vault.key_vault_id
}

output "virtual_network_id" {
  description = "The Virtual Network resource ID."
  value       = module.virtual_network.id
}

output "subnet_id" {
  description = "The Subnet resource ID."
  value       = module.subnet.id
}
