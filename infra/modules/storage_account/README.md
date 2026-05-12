# Storage Account Terraform Module (`mstcls`)

This module provisions a highly secure, production-ready Azure Storage Account following strict organizational and regulatory standards.

---

## Features
- Enforces organization-wide naming convention:
  `{org}-{env}-{app}-storage-{region}-{seq}`
  (e.g., `cg-prod-mstcls-storage-wus2-001`)
- Creates storage account with encryption-at-rest enabled.
- Restrictive network rules (no public endpoints, only allowed VNets/subnets, no 0.0.0.0/0).
- Secure transfer (minimum TLS 1.2 enforced).
- Disables blob public access.
- All resource and output names are unique within scope per compliance rules.
- Diagnostic settings logging to be implemented at parent/root level.

---

## Usage Example

```hcl
module "storage_account" {
  source              = "./modules/storage_account"
  resource_group_name = module.resource_group.name
  location            = var.location
  org                 = var.org
  env                 = var.env
  app                 = var.app
  region              = var.region
  storage_account_sequence = 1
  allowed_subnet_ids  = [module.vnet.app_subnet_id]
  tags                = local.tags
}
```

---

## Inputs
- **resource_group_name**: Name of the Azure Resource Group.
- **location**: Azure region (e.g., `westus2`).
- **org**: Organization code (`cg`).
- **env**: Environment name (`prod`).
- **app**: Application abbreviation (`mstcls`).
- **region**: Region code (`wus2`).
- **storage_account_sequence**: Sequence number for uniqueness (e.g., `1` → `001`).
- **allowed_subnet_ids**: List of subnet resource IDs allowed to access this storage account.
- **tags**: Map of tags to apply.

---

## Security & Compliance
- No secrets, keys, or credentials are handled directly.
- Network rules deny all traffic by default; only specified VNets/subnets can access storage.
- Minimum TLS 1.2 required for all connections.
- Public access is disabled for all blob containers.
- Storage account names comply with Azure's 3-24 lowercase/numeric-only character limitations. The module handles any necessary truncation.
- Module outputs are globally unique and only declared in `outputs.tf`, as per project standards.

See [compliance.md](./compliance.md) for further details.
