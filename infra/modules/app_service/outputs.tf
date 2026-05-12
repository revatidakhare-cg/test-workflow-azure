output "app_service_id" {
  description = "App Service Resource ID."
  value       = azurerm_app_service.main.id
}

output "app_service_default_hostname" {
  description = "App Service default hostname."
  value       = azurerm_app_service.main.default_site_hostname
}

output "app_service_plan_id" {
  description = "App Service Plan Resource ID."
  value       = azurerm_app_service_plan.main.id
}

output "app_service_name" {
  description = "App Service resource name."
  value       = azurerm_app_service.main.name
}

output "app_service_plan_name" {
  description = "App Service Plan resource name."
  value       = azurerm_app_service_plan.main.name
}

output "diagnostic_setting_id" {
  description = "App Service diagnostic setting resource ID."
  value       = azurerm_monitor_diagnostic_setting.main.id
}
