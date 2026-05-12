variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "virtual_network_id" {
  description = "ID of the virtual network"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "org" {
  description = "Organization name"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "app" {
  description = "Application name"
  type        = string
}

variable "region" {
  description = "Azure region abbreviation"
  type        = string
}

variable "nseq" {
  description = "Network sequence number"
  type        = number
  default     = 1
}

variable "address_prefix" {
  description = "CIDR address prefix for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}
