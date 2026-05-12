# Network rules for Storage Account
# Public access is disabled and secure transfer is enforced in main.tf's inline configuration.

resource "azurerm_storage_account_network_rules" "network_rules" {
  storage_account_id   = azurerm_storage_account.main.id
  default_action       = "Deny"
  bypass               = ["AzureServices"]
  ip_rules             = []
}
