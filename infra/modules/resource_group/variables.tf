variable "org" {
  description = "Organization name"
  type        = string
}

variable "env" {
  description = "Environment name (e.g., prod, dev)"
  type        = string
}

variable "app" {
  description = "Application name"
  type        = string
}

variable "region" {
  description = "Azure region abbreviation (e.g., wus2)"
  type        = string
}

variable "location" {
  description = "Azure location (e.g., West US 2)"
  type        = string
  default     = "West US 2"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
