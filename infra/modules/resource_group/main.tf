locals {
  rg_name = format("%s-%s-%s-rg-%s", var.org, var.env, var.app, var.region)
}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = var.tags
}
