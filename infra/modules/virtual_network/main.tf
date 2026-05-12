locals {
  vnet_name = join("-", [
    var.org,
    var.env,
    var.app,
    "vnet",
    var.region,
    "001"
  ])
  # Azure VNet name limit: 64 chars, super unlikely to hit, but we truncate if exceeded
  vnet_name_short = length(local.vnet_name) > 64 ? substr(local.vnet_name, 0, 64) : local.vnet_name
}

resource "azurerm_virtual_network" "main" {
  name                = local.vnet_name_short
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space
  tags                = var.tags
}

resource "azurerm_subnet" "default" {
  name                 = "default"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.default_subnet_prefixes
  depends_on           = [azurerm_virtual_network.main]
}

resource "azurerm_network_security_group" "default_nsg" {
  name                = join("-", [var.org, var.env, var.app, "nsg", var.region, "001"])
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
  depends_on          = [azurerm_virtual_network.main]
}

resource "azurerm_subnet_network_security_group_association" "default_assoc" {
  subnet_id                 = azurerm_subnet.default.id
  network_security_group_id = azurerm_network_security_group.default_nsg.id
  depends_on                = [azurerm_subnet.default, azurerm_network_security_group.default_nsg]
}
