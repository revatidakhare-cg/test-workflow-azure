variable "resource_group_name" {
  description = "Azure Resource Group name."
  type        = string
  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "resource_group_name must be non-empty."
  }
}

variable "location" {
  description = "Azure region (e.g. westus2)."
  type        = string
  validation {
    condition     = length(var.location) > 0
    error_message = "location must be non-empty."
  }
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}

variable "org" {
  description = "Organization prefix (naming standard)."
  type        = string
  validation {
    condition     = length(var.org) > 0
    error_message = "org must be non-empty."
  }
}

variable "env" {
  description = "Environment prefix (naming standard)."
  type        = string
  validation {
    condition     = length(var.env) > 0
    error_message = "env must be non-empty."
  }
}

variable "app" {
  description = "Project abbreviation (naming standard)."
  type        = string
  validation {
    condition     = length(var.app) > 0
    error_message = "app must be non-empty."
  }
}

variable "region" {
  description = "Region code for naming."
  type        = string
  validation {
    condition     = length(var.region) > 0
    error_message = "region must be non-empty."
  }
}

variable "storage_account_name" {
  description = "Storage Account name for App Service diagnostic logs."
  type        = string
  validation {
    condition     = length(var.storage_account_name) > 0
    error_message = "storage_account_name must be non-empty."
  }
}

variable "key_vault_name" {
  description = "Key Vault name for secrets management."
  type        = string
  validation {
    condition     = length(var.key_vault_name) > 0
    error_message = "key_vault_name must be non-empty."
  }
}

variable "tenant_id" {
  description = "Azure Active Directory Tenant ID required for Key Vault."
  type        = string
  validation {
    condition     = length(var.tenant_id) > 0
    error_message = "tenant_id must be non-empty."
  }
}

variable "network_dependency" {
  description = "Explicit dependency for app_service on network resources (e.g., subnet module outputs)."
  type        = list(any)
  default     = []
}
