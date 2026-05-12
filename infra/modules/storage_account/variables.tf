variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account."
  type        = string
  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "resource_group_name must not be empty."
  }
}

variable "location" {
  description = "The Azure Region in which to create the storage account."
  type        = string
  validation {
    condition     = length(var.location) > 0
    error_message = "location must not be empty."
  }
}

variable "tags" {
  description = "A map of tags to assign to the storage account."
  type        = map(string)
  default     = {}
}

variable "org" {
  description = "The organization prefix for resource naming."
  type        = string
  validation {
    condition     = length(var.org) > 0
    error_message = "org must not be empty."
  }
}

variable "env" {
  description = "The environment for resource naming (e.g., prod, dev)."
  type        = string
  validation {
    condition     = length(var.env) > 0
    error_message = "env must not be empty."
  }
}

variable "app" {
  description = "Project abbreviation for resource naming."
  type        = string
  validation {
    condition     = length(var.app) > 0
    error_message = "app must not be empty."
  }
}

variable "region" {
  description = "Region code for resource naming."
  type        = string
  validation {
    condition     = length(var.region) > 0
    error_message = "region must not be empty."
  }
}

variable "storage_account_sequence" {
  description = "Three-digit sequence for storage account naming."
  type        = string
  validation {
    condition     = length(var.storage_account_sequence) == 3
    error_message = "storage_account_sequence must be a 3-character string (e.g., '001')."
  }
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account. Valid values are Standard and Premium."
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account. Valid values include LRS, GRS, RAGRS, ZRS."
  type        = string
  default     = "LRS"
}

variable "enable_https_traffic_only" {
  description = "Allows only https traffic to storage if true. Highly recommended for security."
  type        = bool
  default     = true
}

variable "min_tls_version" {
  description = "The minimum TLS version to be permitted on requests to storage. Must be TLS1_2 for compliance."
  type        = string
  default     = "TLS1_2"
}

variable "allow_blob_public_access" {
  description = "Allow or disallow public blob access. Should be false for security."
  type        = bool
  default     = false
}

variable "enable_soft_delete" {
  description = "Enable soft delete for blobs."
  type        = bool
  default     = true
}

variable "allowed_subnet_ids" {
  description = "List of allowed subnet resource IDs for storage account network access."
  type        = list(string)
  default     = []
}

variable "log_analytics_workspace_id" {
  description = "Optional Log Analytics workspace ID for diagnostic settings."
  type        = string
  default     = null
}
