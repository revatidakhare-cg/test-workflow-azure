# Key Vault module: main.tf
resource "azurerm_key_vault" "this" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  enabled_for_deployment      = true
  enabled_for_disk_encryption = true
  enabled_for_template_deployment = true
  purge_protection_enabled    = true
  enable_rbac_authorization   = true
  network_acls {
    bypass              = "AzureServices"
    default_action      = "Deny"
    ip_rules            = var.allowed_ip_ranges
    virtual_network_subnet_ids = var.allowed_subnet_ids
  }
  tags = var.tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_key_vault_secret" "admin_password" {
  name         = "admin-password"
  value        = var.admin_password
  key_vault_id = azurerm_key_vault.this.id
  content_type = "password"
  depends_on   = [azurerm_key_vault.this]
}

resource "azurerm_monitor_diagnostic_setting" "key_vault_logs" {
  name                       = "${var.key_vault_name}-diag"
  target_resource_id         = azurerm_key_vault.this.id
  storage_account_id         = var.diagnostic_storage_account_id
  log {
    category = "AuditEvent"
    enabled  = true
    retention_policy {
      enabled = true
      days    = var.diagnostic_retention_days
    }
  }
  metric {
    category = "AllMetrics"
    enabled  = true
    retention_policy {
      enabled = true
      days    = var.diagnostic_retention_days
    }
  }
  depends_on = [azurerm_key_vault.this]
}
