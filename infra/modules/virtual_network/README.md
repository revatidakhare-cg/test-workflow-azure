# Virtual Network Module

## Overview
This Terraform module provisions a secure, compliant Azure Virtual Network with strict naming standards and tagging. Subnets and NSGs must be added via dependent modules or explicit configuration.

## Features
- Enforces naming: `{org}-{env}-{app}-vnet-{region}-{seq}`
- Tags: org, app, env, region, plus custom
- Diagnostic logging enabled
- Restrictive, non-default networking rules
- All variable references passed from root as single source of truth

## Usage
```
module "virtual_network" {
  source              = "./modules/virtual_network"
  resource_group_name = var.resource_group_name
  location            = var.location
  org                 = var.org
  env                 = var.env
  app                 = var.app
  region              = var.region
  tags                = var.tags
}
```

### Required Variables
- `resource_group_name` (string): Name of the Azure Resource Group
- `location` (string): Azure region code
- `org` (string): Organization prefix (e.g. cg)
- `env` (string): Environment name (e.g. prod)
- `app` (string): Application short name (e.g. mstcls)
- `region` (string): Azure region code for naming
- `tags` (map): Map of resource tags

### Outputs
- `vnet_id` (string): ID of the Virtual Network
- `vnet_name` (string): Name of the Virtual Network
- `vnet_address_space` (list): Address space for the VNet

## Compliance
See [compliance.md](./compliance.md) for detailed controls and standards.

---
