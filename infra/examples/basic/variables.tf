variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "Resource group name must not be empty."
  }
}

variable "location" {
  description = "Azure region location code (e.g., westus2)"
  type        = string
  validation {
    condition     = length(var.location) > 0
    error_message = "Location must not be empty."
  }
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  validation {
    condition     = length(keys(var.tags)) > 0
    error_message = "Tags map must contain at least one tag."
  }
}

variable "org" {
  description = "Organization abbreviation (cg)"
  type        = string
  validation {
    condition     = length(var.org) > 0
    error_message = "Organization abbreviation must not be empty."
  }
}

variable "env" {
  description = "Environment (prod)"
  type        = string
  validation {
    condition     = length(var.env) > 0
    error_message = "Environment must not be empty."
  }
}

variable "app" {
  description = "Project abbreviation (mstcls)"
  type        = string
  validation {
    condition     = length(var.app) > 0
    error_message = "Project abbreviation must not be empty."
  }
}

variable "region" {
  description = "Region code (wus2)"
  type        = string
  validation {
    condition     = length(var.region) > 0
    error_message = "Region code must not be empty."
  }
}

variable "kv_seq" {
  description = "Key Vault sequence number (e.g. 001)"
  type        = string
  validation {
    condition     = length(var.kv_seq) > 0
    error_message = "Sequence number must not be empty."
  }
}

variable "keyvault_access_policies" {
  description = "List of access policies for Key Vault"
  type        = list(object({
    tenant_id                = string
    object_id                = string
    key_permissions          = list(string)
    secret_permissions       = list(string)
    certificate_permissions  = list(string)
    storage_permissions      = list(string)
  }))
  validation {
    condition     = length(var.keyvault_access_policies) > 0
    error_message = "At least one access policy must be defined."
  }
}

variable "vnet_id" {
  description = "Virtual Network resource id to link Key Vault network access"
  type        = string
  validation {
    condition     = length(var.vnet_id) > 0
    error_message = "Virtual network id must not be empty."
  }
}

variable "subnet_id" {
  description = "Subnet resource id for Key Vault network rule"
  type        = string
  validation {
    condition     = length(var.subnet_id) > 0
    error_message = "Subnet id must not be empty."
  }
}
