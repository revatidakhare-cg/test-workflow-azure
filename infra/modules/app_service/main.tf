# Create App Service Plan (required for App Service)
resource "azurerm_app_service_plan" "main" {
  name                = local.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku {
    tier = "PremiumV2"
    size = "P1v2"
  }
  tags = var.tags

  depends_on = [
    var.network_dependency
  ]
}

# Create App Service
resource "azurerm_app_service" "main" {
  name                = local.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.main.id

  https_only          = true
  tags                = var.tags

  site_config {
    dotnet_framework_version = "v6.0"
    ftps_state               = "Disabled"
    min_tls_version          = "1.2"
  }

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_app_service_plan.main,
    var.network_dependency
  ]
}

# Enable Diagnostic Logging
resource "azurerm_monitor_diagnostic_setting" "main" {
  name               = local.diagnostic_setting_name
  target_resource_id = azurerm_app_service.main.id
  storage_account_id = data.azurerm_storage_account.main.id
  log {
    category = "AppServiceHTTPLogs"
    enabled  = true
  }
  log {
    category = "AppServiceConsoleLogs"
    enabled  = true
  }
  metric {
    category = "AllMetrics"
    enabled  = true
  }

  depends_on = [
    azurerm_app_service.main
  ]
}

# Locals for naming
locals {
  app_service_seq           = "001"
  app_service_plan_seq      = "001"
  diagnostic_setting_seq    = "001"

  # App Service Name
  app_service_name = lower(
    substr(
      format("%s-%s-%s-app-%s-%s", var.org, var.env, var.app, var.region, local.app_service_seq),
      0,
      64
    )
  )

  # App Service Plan Name
  app_service_plan_name = lower(
    substr(
      format("%s-%s-%s-plan-%s-%s", var.org, var.env, var.app, var.region, local.app_service_plan_seq),
      0,
      40
    )
  )

  # Diagnostic Setting Name
  diagnostic_setting_name = lower(
    substr(
      format("%s-%s-%s-dg-%s-%s", var.org, var.env, var.app, var.region, local.diagnostic_setting_seq),
      0,
      64
    )
  )
}

# Reference dependent modules - storage account and key vault are created externally
data "azurerm_storage_account" "main" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault" "main" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}
