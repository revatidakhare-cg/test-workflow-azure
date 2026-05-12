# Windows Virtual Machine Module: cg-prod-mstcls-vm-wus2-001

## Overview
Terraform module to provision a secure Azure Windows VM compliant with cg-prod-mstcls-vm-wus2-001 naming, restrictive networking rules, and rigorous compliance standards for the "prod" environment of project "cloudboost" ("mstcls"), region "wus2".

### Features
- Strict Terraform version (>=1.14.8, <2.0.0).
- Naming pattern: `cg-prod-mstcls-vm-wus2-001`.
- Restrictive NSG rules:
  - Deny RDP from all except trusted admin subnets.
  - Allow HTTP only from App Service subnet.
  - Block all other inbound traffic.
- Encryption at rest (OS & data disks).
- Minimum TLS 1.2 enforced.
- Diagnostic logging enabled.
- All credentials managed via Azure Key Vault.
- Identity-based backend authentication; no access keys.
- Comprehensive tagging.

## Usage

```hcl
module "windows_virtual_machine" {
  source                  = "./modules/windows_virtual_machine"
  resource_group_name     = var.resource_group_name
  location                = var.location
  org                     = var.org                  # "cg"
  env                     = var.env                  # "prod"
  app                     = var.app                  # "mstcls"
  region                  = var.region               # "wus2"
  tags                    = var.tags
  trusted_admin_subnets   = ["10.0.0.0/24"]         # Example
  app_service_subnets     = ["10.0.1.0/24"]         # Example
}
```

## Inputs
- `resource_group_name`: Name of the Azure Resource Group.
- `location`: Azure region (must be "wus2").
- `org`: Organization ("cg").
- `env`: Environment ("prod").
- `app`: Project abbreviation ("mstcls").
- `region`: Region code ("wus2").
- `tags`: Map of tags for compliance and inventory.
- `trusted_admin_subnets`: List of admin subnet CIDRs allowed RDP.
- `app_service_subnets`: List of subnet CIDRs allowed HTTP access.

## Outputs
> Outputs are defined exclusively in outputs.tf. No outputs in main.tf or other files.

## Compliance & Security
- All resources comply with encryption-at-rest, minimum TLS 1.2, and logging requirements.
- Network access locked to trusted sources only.
- Resource name and tag compliance enforced.

## Execution Order
- Resource Group → VNet → Subnet → NSG (this module) → VM.

## Module Structure
- main.tf – Resource definitions
- variables.tf – Input declarations
- outputs.tf – Output definitions
- rules.tf – Restrictive NSG rules
- policies.tf – Policy assignments (if used)
- compliance.md – Documentation
- README.md – Module usage and guide

## License
See LICENSE in the root of the repo.
