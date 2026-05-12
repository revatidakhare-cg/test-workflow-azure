# Key Vault Module

## Overview

This module provisions a highly secure Azure Key Vault for the CloudBoost production environment. The Key Vault is named strictly according to the enforced naming convention:

- **Pattern:** `{org}-{env}-{app}-keyvault-{region}-{seq}`
- **Example Name:** `cg-prod-mstcls-keyvault-wus2-001`

All resources comply with Azure name length constraints and the core naming structure is preserved. The module ensures minimum TLS 1.2, encryption-at-rest, and diagnostic logging, with no hardcoded secrets. Access policies are tightly scoped, supporting identity-based authentication.

## Security & Compliance

- **TLS:** Minimum version enforced is TLS 1.2
- **Encryption:** All secrets, keys and certificates are encrypted at rest
- **Diagnostics:** Logging is enabled
- **Tagging:** All resources are centrally tagged with org, env, app, region
- **Policies:** Only allow access from specified identities and networks

## Inputs

| Name                  | Description                        | Type      | Required |
|---------------------- |------------------------------------|-----------|----------|
| resource_group_name   | Name of the Azure Resource Group    | string    | Yes      |
| location              | Azure region location code          | string    | Yes      |
| tags                  | Resource tags map                   | map(string)| Yes     |
| org                   | Organization abbreviation           | string    | Yes      |
| env                   | Environment (prod)                  | string    | Yes      |
| app                   | App abbreviation                    | string    | Yes      |
| region                | Region code (wus2)                  | string    | Yes      |
| kv_seq                | Sequence number (001)               | string    | Yes      |
| keyvault_access_policies | List of access policies           | list(object) | Yes   |
| vnet_id               | Virtual Network resource id         | string    | Yes      |
| subnet_id             | Subnet resource id                  | string    | Yes      |

## Outputs

| Name           | Description                                        |
|----------------|----------------------------------------------------|
| keyvault_id    | The resource ID of the Key Vault                   |
| keyvault_name  | The unique name of the Key Vault                   |
| keyvault_uri   | The URI endpoint for the Key Vault                 |

## Usage

```
module "key_vault" {
  source               = "./modules/key_vault"
  resource_group_name  = var.resource_group_name
  location             = var.location
  tags                 = var.tags
  org                  = var.org
  env                  = var.env
  app                  = var.app
  region               = var.region
  kv_seq               = var.kv_seq
  keyvault_access_policies = var.keyvault_access_policies
  vnet_id              = var.vnet_id
  subnet_id            = var.subnet_id
}
```

## Compliance Reference

- [Azure Key Vault Security Baseline](https://learn.microsoft.com/en-us/azure/key-vault/general/security-baseline)
- [Minimum TLS Version](https://learn.microsoft.com/en-us/azure/key-vault/general/about-tls)

