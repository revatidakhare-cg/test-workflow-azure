locals {
  subnet_name = format("%s-%s-%s-subnet-%s-%03d", var.org, var.env, var.app, var.region, var.nseq)
}

resource "azurerm_subnet" "subnet" {
  name                 = local.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefixes     = [var.address_prefix]
}

data "azurerm_virtual_network" "vnet" {
  name                = split("/", var.virtual_network_id)[8]
  resource_group_name = var.resource_group_name
}
