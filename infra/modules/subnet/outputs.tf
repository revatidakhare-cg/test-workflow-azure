output "id" {
  description = "ID of the subnet"
  value       = azurerm_subnet.subnet.id
}

output "name" {
  description = "Name of the subnet"
  value       = azurerm_subnet.subnet.name
}
