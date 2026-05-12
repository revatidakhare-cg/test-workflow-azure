variable "resource_group_name" {
  description = "Name of the resource group for deployment."
  type        = string
  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "Resource group name must not be empty."
  }
}

variable "location" {
  description = "Azure region where resources are deployed."
  type        = string
  validation {
    condition     = length(var.location) > 0
    error_message = "Location must not be empty."
  }
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {
    environment = "prod"
    project     = "cloudboost"
    owner       = "cg"
  }
  validation {
    condition     = contains(keys(var.tags), "environment") && contains(keys(var.tags), "project") && contains(keys(var.tags), "owner")
    error_message = "Tags map must contain environment, project, and owner keys."
  }
}

variable "org" {
  description = "Organization code (e.g., cg)"
  type        = string
  validation {
    condition     = length(var.org) > 0
    error_message = "Organization must not be empty."
  }
}

variable "env" {
  description = "Deployment environment (e.g., prod)"
  type        = string
  validation {
    condition     = length(var.env) > 0
    error_message = "Environment must not be empty."
  }
}

variable "app" {
  description = "Project application abbreviation (e.g., mstcls)"
  type        = string
  validation {
    condition     = length(var.app) > 0
    error_message = "Application abbreviation must not be empty."
  }
}

variable "region" {
  description = "Region code (e.g., wus2)"
  type        = string
  validation {
    condition     = length(var.region) > 0
    error_message = "Region code must not be empty."
  }
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  validation {
    condition     = length(var.subscription_id) > 0
    error_message = "Subscription ID must not be empty."
  }
}

variable "windows_vm_admin_username" {
  description = "Admin username for Windows VMs"
  type        = string
  validation {
    condition     = length(var.windows_vm_admin_username) > 0
    error_message = "Admin username must not be empty."
  }
}

variable "windows_vm_admin_password_secret_uri" {
  description = "URI to the Key Vault secret containing the Windows VM admin password"
  type        = string
  validation {
    condition     = length(var.windows_vm_admin_password_secret_uri) > 0
    error_message = "Admin password secret URI must not be empty."
  }
}

variable "windows_vm_admin_password" {
  description = "Admin password for Windows VMs (if not stored in Key Vault)"
  type        = string
  sensitive   = true
  default     = "TempPassword123!@#"  # IMPORTANT: Replace with actual password or use Key Vault reference
  validation {
    condition     = length(var.windows_vm_admin_password) >= 12
    error_message = "Admin password must be at least 12 characters long."
  }
}

variable "trusted_admin_subnets" {
  description = "List of trusted admin subnets for RDP access"
  type        = list(string)
  default     = []
}

variable "app_service_subnets" {
  description = "List of app service subnets CIDR blocks"
  type        = list(string)
  default     = []
}

variable "vm_size" {
  description = "Azure VM size for Windows VMs"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "tenant_id" {
  description = "Azure AD Tenant ID for Key Vault and identity"
  type        = string
  validation {
    condition     = length(var.tenant_id) > 0
    error_message = "Tenant ID must not be empty."
  }
}

variable "ad_admin_object_id" {
  description = "Object ID of Azure AD admin for Key Vault policy"
  type        = string
  validation {
    condition     = length(var.ad_admin_object_id) > 0
    error_message = "AD admin object ID must not be empty."
  }
}

variable "image_publisher" {
  description = "Publisher of the VM image (e.g., MicrosoftWindowsServer)"
  type        = string
  default     = "MicrosoftWindowsServer"
}

variable "image_offer" {
  description = "Offer of the VM image (e.g., WindowsServer)"
  type        = string
  default     = "WindowsServer"
}

variable "image_sku" {
  description = "SKU of the VM image (e.g., 2022-datacenter)"
  type        = string
  default     = "2022-datacenter"
}
