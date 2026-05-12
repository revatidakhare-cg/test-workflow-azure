# modules/windows_virtual_machine/main.tf

locals {
  vm_seq              = "001"
  vm_base_name        = format("%s-%s-%s-vm-%s-%s", var.org, var.env, var.app, var.region, local.vm_seq) # cg-prod-mstcls-vm-wus2-001
  vm_name_raw         = local.vm_base_name
  vm_name             = length(local.vm_base_name) > 80 ? substr(local.vm_base_name, 0, 80) : local.vm_base_name
  storage_base_name   = format("%s%s%sstorage%s%s", lower(var.org), lower(var.env), lower(var.app), lower(var.region), local.vm_seq) # cgprodmstclsstoragewus2001
  storage_name        = length(local.storage_base_name) > 24 ? substr(local.storage_base_name, 0, 24) : local.storage_base_name
  final_storage_name  = var.storage_account_name_override != "" ? var.storage_account_name_override : local.storage_name
  # Defensive: Ensure storage account override is valid
  storage_override_valid = var.storage_account_name_override == "" || (
    length(var.storage_account_name_override) <= 24 && can(regex("^[a-z0-9]+$", var.storage_account_name_override))
  )
  # Defensive NIC name check (Azure limit 80 chars)
  vm_nic_name_raw = "${local.vm_name}-nic"
  vm_nic_name     = length(local.vm_nic_name_raw) > 80 ? substr(local.vm_nic_name_raw, 0, 80) : local.vm_nic_name_raw
  # Defensive Diagnostic Setting name check (Azure max 64 chars)
  vm_diag_name_raw = "${local.vm_name}-diagnostic"
  vm_diag_name     = length(local.vm_diag_name_raw) > 64 ? substr(local.vm_diag_name_raw, 0, 64) : local.vm_diag_name_raw
  storage_diag_name_raw = "${local.final_storage_name}-diagnostic"
  storage_diag_name     = length(local.storage_diag_name_raw) > 64 ? substr(local.storage_diag_name_raw, 0, 64) : local.storage_diag_name_raw
  # Key Vault name validation - Azure max 24 chars, allow hyphens
  keyvault_name_base = format("%s-%s-%s-keyvault-%s-%s", var.org, var.env, var.app, var.region, local.vm_seq)
  keyvault_name      = length(local.keyvault_name_base) > 24 ? substr(local.keyvault_name_base, 0, 24) : local.keyvault_name_base
}

resource "azurerm_network_interface" "windows_vm_nic" {
  name                = local.vm_nic_name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "${local.vm_name}-ipcfg"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
  tags = var.tags
  depends_on = [azurerm_storage_account.windows_vm_storage, azurerm_key_vault.windows_vm_keyvault]
}

resource "azurerm_monitor_diagnostic_setting" "windows_vm_diag" {
  name               = local.vm_diag_name
  target_resource_id = azurerm_windows_virtual_machine.windows_vm.id
  storage_account_id = azurerm_storage_account.windows_vm_storage.id
  metric {
    category = "AllMetrics"
    enabled  = true
  }
  log {
    category = "AuditLogs"
    enabled  = true
  }
  log {
    category = "Security"
    enabled  = true
  }
}

data "azurerm_key_vault_secret" "windows_vm_admin_password" {
  name         = "windowsvm-admin-password"
  key_vault_id = var.keyvault_id
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  name                = local.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = data.azurerm_key_vault_secret.windows_vm_admin_password.value
  network_interface_ids = [azurerm_network_interface.windows_vm_nic.id]
  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = "latest"
  }
  os_disk {
    name                 = "${local.vm_name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = var.os_disk_size_gb
  }
  identity {
    type = "SystemAssigned"
  }
  tags = var.tags
  depends_on = [azurerm_network_interface.windows_vm_nic, azurerm_storage_account.windows_vm_storage, azurerm_key_vault.windows_vm_keyvault]
}

resource "azurerm_storage_account" "windows_vm_storage" {
  name                              = local.final_storage_name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  account_tier                      = "Premium"
  account_replication_type          = "LRS"
  https_traffic_only_enabled        = true
  min_tls_version                   = "TLS1_2"
  tags                              = var.tags
  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }
  queue_properties {
    logging {
      read                = true
      write               = true
      delete              = true
      version             = "1.0"
      retention_policy_days = 7
    }
  }
  depends_on = []
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_monitor_diagnostic_setting" "windows_vm_storage_diag" {
  name               = local.storage_diag_name
  target_resource_id = azurerm_storage_account.windows_vm_storage.id
  storage_account_id = azurerm_storage_account.windows_vm_storage.id
  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

resource "azurerm_key_vault" "windows_vm_keyvault" {
  name                        = local.keyvault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = "premium"
  enabled_for_disk_encryption = true
  enable_rbac_authorization   = true
  purge_protection_enabled = true
  tags = var.tags
  depends_on = []
}
