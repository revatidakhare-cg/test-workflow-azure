variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the resources."
  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "resource_group_name must not be empty."
  }
}

variable "location" {
  type        = string
  description = "The Azure region where the resources will be created."
  validation {
    condition     = length(var.location) > 0
    error_message = "location must not be empty."
  }
}

variable "org" {
  type        = string
  description = "Organization identifier."
  validation {
    condition     = length(var.org) > 0
    error_message = "org must not be empty."
  }
}

variable "env" {
  type        = string
  description = "Environment (prod, dev, etc.)."
  validation {
    condition     = length(var.env) > 0
    error_message = "env must not be empty."
  }
}

variable "app" {
  type        = string
  description = "Application code/abbreviation."
  validation {
    condition     = length(var.app) > 0
    error_message = "app must not be empty."
  }
}

variable "region" {
  type        = string
  description = "Azure region code (e.g. wus2)."
  validation {
    condition     = length(var.region) > 0
    error_message = "region must not be empty."
  }
}

variable "tags" {
  type    = map(string)
  default = {}
  description = "Resource tags."
}

variable "address_space" {
  type        = list(string)
  description = "Address space for the virtual network."
}

variable "default_subnet_prefixes" {
  type        = list(string)
  description = "Address prefixes for the default subnet."
}
