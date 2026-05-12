# Virtual Network Outputs
output "id" {
  description = "The ID of the Virtual Network."
  value       = azurerm_virtual_network.main.id
}

output "name" {
  description = "The name of the Virtual Network."
  value       = azurerm_virtual_network.main.name
}

output "address_space" {
  description = "The address space of the Virtual Network."
  value       = azurerm_virtual_network.main.address_space
}
