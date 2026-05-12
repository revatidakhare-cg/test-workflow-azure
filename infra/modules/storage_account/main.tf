locals {
  sa_base              = "${var.org}-${var.env}-${var.app}-storage-${var.region}-001"
  # Enforce Azure storage account rules: 3-24 chars, only lowercase letters and numbers
  sa_name_trunc        = substr(replace(lower(local.sa_base), "[^a-z0-9]", ""), 0, 24)
}

resource "azurerm_storage_account" "main" {
  name                              = local.sa_name_trunc
  resource_group_name               = var.resource_group_name
  location                          = var.location
  account_tier                      = "Standard"
  account_replication_type          = "LRS"
  min_tls_version                   = "TLS1_2"
  allow_nested_items_to_be_public   = false
  https_traffic_only_enabled        = true
  is_hns_enabled                    = true # Hierarchical namespace for Data Lake Security

  identity {
    type = "SystemAssigned"
  }

  network_rules {
    default_action             = "Deny"
    bypass                     = ["AzureServices"]
    ip_rules                   = []
    virtual_network_subnet_ids = var.allowed_subnet_ids
  }

  tags = merge(var.tags, {
    org    = var.org
    env    = var.env
    app    = var.app
    region = var.region
  })

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_monitor_diagnostic_setting" "sa_diag" {
  name                       = "audit-diag"
  target_resource_id         = azurerm_storage_account.main.id
  storage_account_id         = azurerm_storage_account.main.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "StorageRead"
  }
  enabled_log {
    category = "StorageWrite"
  }
  enabled_log {
    category = "StorageDelete"
  }
  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
