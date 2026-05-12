terraform {
  required_version = "= 1.14.8"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# -----------------------------------------------------------------------------
# Resource Group
# -----------------------------------------------------------------------------

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# -----------------------------------------------------------------------------
# Storage Account (example workload)
# -----------------------------------------------------------------------------

resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

# Example output that the pipeline attempts to read
output "example_app_url" {
  description = "Example endpoint for the deployed resource (storage primary web endpoint)."
  value       = azurerm_storage_account.sa.primary_web_endpoint
}

# -----------------------------------------------------------------------------
# Variables
# -----------------------------------------------------------------------------

variable "resource_group_name" {
  description = "Name of the Azure Resource Group."
  type        = string
  default     = "tf-example-rg"
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
  default     = "eastus"
}

variable "storage_account_name" {
  description = "Globally unique name for the storage account. Must be 3-24 lowercase letters and numbers."
  type        = string
  default     = "tfexamplestorageacct01"
}

variable "tags" {
  description = "A map of tags to apply to all resources."
  type        = map(string)
  default = {
    environment = "dev"
    managed-by  = "terraform"
  }
}