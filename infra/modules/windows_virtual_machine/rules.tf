# Restrictive NSG rules for Windows Virtual Machine
# Naming follows: cg-prod-mstcls-nsg-wus2-001

resource "azurerm_network_security_group" "winvm_nsg" {
  name                = "cg-prod-mstcls-nsg-wus2-001"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  security_rule {
    name                       = "cg-prod-mstcls-winvm-RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefixes    = ["0.0.0.0/0"]
    destination_address_prefix = "*"
    description                = "Deny RDP from Internet for compliance."
  }

  security_rule {
    name                       = "cg-prod-mstcls-winvm-RDP-from-Trusted"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefixes    = var.trusted_admin_subnets    # e.g., ["10.0.0.0/24"]
    destination_address_prefix = "*"
    description                = "Allow RDP only from trusted admin subnet(s)."
  }

  security_rule {
    name                       = "cg-prod-mstcls-winvm-AllowAppService"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefixes    = var.app_service_subnets
    destination_address_prefix = "*"
    description                = "Allow HTTP traffic only from app service subnet(s)."
  }
}
