# modules/windows_virtual_machine/outputs.tf

output "vm_id" {
  description = "The unique ID of the Windows Virtual Machine."
  value       = azurerm_windows_virtual_machine.windows_vm.id
}

output "vm_name" {
  description = "The name of the Windows Virtual Machine."
  value       = azurerm_windows_virtual_machine.windows_vm.name
}

output "vm_private_ip" {
  description = "The private IP address assigned to the Windows VM."
  value       = azurerm_network_interface.windows_vm_nic.ip_configuration[0].private_ip_address
}

output "vm_admin_username" {
  description = "The admin username used to configure the Windows VM."
  value       = azurerm_windows_virtual_machine.windows_vm.admin_username
}

output "vm_nic_id" {
  description = "The ID of the Windows VM Network Interface."
  value       = azurerm_network_interface.windows_vm_nic.id
}
