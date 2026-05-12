# VARIABLES for Windows Virtual Machine module
variable "resource_group_name" {
  description = "Resource Group name for the Windows VM resource."
  type        = string
  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "resource_group_name cannot be empty."
  }
}

variable "location" {
  description = "Azure region location."
  type        = string
  validation {
    condition     = length(var.location) > 0
    error_message = "location cannot be empty."
  }
}

variable "org" {
  description = "Organization prefix (short)."
  type        = string
  validation {
    condition     = length(var.org) > 0
    error_message = "org cannot be empty."
  }
}

variable "env" {
  description = "Environment (e.g. prod, dev)."
  type        = string
  validation {
    condition     = length(var.env) > 0
    error_message = "env cannot be empty."
  }
}

variable "app" {
  description = "Project application abbreviation."
  type        = string
  validation {
    condition     = length(var.app) > 0
    error_message = "app cannot be empty."
  }
}

variable "region" {
  description = "Azure short region code, e.g. 'wus2'."
  type        = string
  validation {
    condition     = length(var.region) > 0
    error_message = "region cannot be empty."
  }
}

variable "tags" {
  description = "Map of tags to apply to the VM and related resources."
  type        = map(string)
  default     = {}
  validation {
    condition     = contains(keys(var.tags), "environment") && contains(keys(var.tags), "project") && contains(keys(var.tags), "owner")
    error_message = "Tags map must contain environment, project, and owner keys."
  }
}

variable "subnet_id" {
  description = "ID of the subnet for the VM NIC attachment."
  type        = string
  validation {
    condition     = length(var.subnet_id) > 0
    error_message = "subnet_id cannot be empty."
  }
}

variable "nsg_id" {
  description = "ID of the NSG to associate with the VM NIC."
  type        = string
  validation {
    condition     = length(var.nsg_id) > 0
    error_message = "nsg_id cannot be empty."
  }
}
variable "keyvault_id" {
  description = "Resource ID of Key Vault for the VM module."
  type        = string
  validation {
    condition     = length(var.keyvault_id) > 0
    error_message = "keyvault_id cannot be empty."
  }
}
variable "admin_username" {
  description = "Admin username for Windows VM."
  type        = string
  validation {
    condition     = length(var.admin_username) > 0
    error_message = "admin_username cannot be empty."
  }
}
variable "admin_password_secret_uri" {
  description = "Key Vault secret URI for Windows VM admin password."
  type        = string
  validation {
    condition     = length(var.admin_password_secret_uri) > 0
    error_message = "admin_password_secret_uri cannot be empty."
  }
}
variable "trusted_admin_subnets" {
  description = "List of trusted admin subnets CIDR blocks."
  type        = list(string)
  default     = []
}
variable "app_service_subnets" {
  description = "List of app service subnets CIDR blocks."
  type        = list(string)
  default     = []
}
variable "vm_size" {
  description = "Azure VM size."
  type        = string
  default     = "Standard_DS2_v2"
  validation {
    condition     = can(regex("^Standard_[A-Za-z0-9]+_v[0-9]+$", var.vm_size))
    error_message = "VM size must follow pattern Standard_<sku>_v<seq> (e.g., Standard_DS2_v2)."
  }
}
variable "tenant_id" {
  description = "Tenant ID for Azure AD."
  type        = string
  validation {
    condition     = length(var.tenant_id) > 0
    error_message = "tenant_id cannot be empty."
  }
}
variable "ad_admin_object_id" {
  description = "Object ID of Azure AD admin for Key Vault policy."
  type        = string
  validation {
    condition     = length(var.ad_admin_object_id) > 0
    error_message = "ad_admin_object_id cannot be empty."
  }
}
variable "storage_account_name_override" {
  description = "Override storage account name for edge cases; must be <=24 chars, lowercase alphanumeric only."
  type        = string
  default     = ""
  validation {
    condition     = var.storage_account_name_override == "" || (length(var.storage_account_name_override) <= 24 && can(regex("^[a-z0-9]+$", var.storage_account_name_override)))
    error_message = "Storage Account override must be <=24 chars and only lowercase letters and numbers."
  }
}
variable "image_publisher" {
  description = "VM Image publisher"
  type        = string
  validation {
    condition     = length(var.image_publisher) > 0
    error_message = "VM image_publisher cannot be empty."
  }
}
variable "image_offer" {
  description = "VM Image offer"
  type        = string
  validation {
    condition     = length(var.image_offer) > 0
    error_message = "VM image_offer cannot be empty."
  }
}
variable "image_sku" {
  description = "VM Image SKU"
  type        = string
  validation {
    condition     = length(var.image_sku) > 0
    error_message = "VM image_sku cannot be empty."
  }
}
variable "os_disk_size_gb" {
  description = "Size for OS disk (GB)."
  type        = number
  default     = 128
  validation {
    condition     = var.os_disk_size_gb >= 64 && var.os_disk_size_gb <= 2048
    error_message = "OS disk size must be between 64 and 2048 GB."
  }
}
