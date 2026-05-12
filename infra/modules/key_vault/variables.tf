# Key Vault module: variables.tf
variable "key_vault_name" {
  description = "The name of the Key Vault instance."
  type        = string
  validation {
    condition     = length(var.key_vault_name) > 0 && length(var.key_vault_name) < 25
    error_message = "Key Vault name must be between 1 and 24 characters."
  }
}

variable "location" {
  description = "Azure location for Key Vault."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the Key Vault."
  type        = string
}

variable "tenant_id" {
  description = "Azure Active Directory tenant ID."
  type        = string
}

variable "admin_object_id" {
  description = "Object ID of the admin principal for Key Vault access policy."
  type        = string
}

variable "admin_password" {
  description = "Admin password to be stored as a secret. Value must be strong & non-empty."
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.admin_password) > 0
    error_message = "Admin password must not be empty."
  }
}

variable "tags" {
  description = "Tags for Key Vault."
  type        = map(string)
}

variable "allowed_ip_ranges" {
  description = "List of allowed public IP addresses for Key Vault access."
  type        = list(string)
  default     = []
}

variable "allowed_subnet_ids" {
  description = "List of allowed subnet resource IDs for private endpoint access."
  type        = list(string)
  default     = []
}

variable "diagnostic_storage_account_id" {
  description = "Resource ID of the storage account for diagnostic logs."
  type        = string
}

variable "diagnostic_retention_days" {
  description = "Number of days to keep diagnostic logs."
  type        = number
  default     = 30
  validation {
    condition     = var.diagnostic_retention_days > 0 && var.diagnostic_retention_days <= 365
    error_message = "Diagnostic retention days must be between 1 and 365."
  }
}
