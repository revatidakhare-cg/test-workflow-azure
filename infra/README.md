# cloudboost Production Terraform Project (cg-mstcls-prod-wus2)

## Inventory
- **Windows Virtual Machine** (1 instance)
- **App Service** (1 instance)
- **Virtual Network** (1 instance)
- **Storage Account** (1 instance)
- **Key Vault** (1 instance)

## Naming Standards
| Resource Type           | Naming Pattern                                 | Example Value                    |
|------------------------|------------------------------------------------|----------------------------------|
| Windows Virtual Machine | `{org}-{env}-{app}-vm-{region}-{seq}`          | cg-prod-mstcls-vm-wus2-001       |
| App Service            | `{org}-{env}-{app}-app-{region}-{seq}`         | cg-prod-mstcls-app-wus2-001      |
| Virtual Network        | `{org}-{env}-{app}-vnet-{region}-{seq}`        | cg-prod-mstcls-vnet-wus2-001     |
| Storage Account        | `{org}{env}{app}storage{region}{seq}` *(see below)* | cgprodmstclsstoragewus2001       |
| Key Vault              | `{org}-{env}-{app}-keyvault-{region}-{seq}`    | cg-prod-mstcls-keyvault-wus2-001 |

- All resource names strictly follow provider-length and character requirements.
- **Storage Account** names: Azure requires <=24 chars, only lowercase letters and numbers, **no hyphens**. Pattern: `{org}{env}{app}storage{region}{seq}`. Example: `cgprodmstclsstoragewus2001`. 
- *Storage Account naming pattern deviation is fully intentional and compliant with Azure's constraints on allowed characters (no hyphens) and length. Storage Account resources must strictly adhere to these Azure requirements, which are enforced and validated in the module logic. All other resources use hyphens for clarity and to meet standard naming across the project.*

## Security & Compliance
- Azure AD authentication (identity-based) for backend, no access keys.
- Minimum TLS 1.2, encryption-at-rest, diagnostic logging enforced.
- No hardcoded secrets; admin credentials safely stored in Azure Key Vault.
- Network rules: Restrictive, no open access (no 0.0.0.0/0).

## Repository Layout
- Root: `README.md`, `LICENSE`, `versions.tf`, `providers.tf`, `backend.tf`, `main.tf`, `variables.tf`, `outputs.tf`, `terraform.tfvars`
- Modular resources: `modules/<resource>/` with full compliance documentation.

## Version Pinning
- **Terraform version strictly pinned:** >= 1.14.8, < 2.0.0
- See official installation page: [Terraform Install Guide](https://developer.hashicorp.com/terraform/install)

## How To Use
1. Install a Terraform version between 1.14.8 and <2.0.0 from HashiCorp using link above.
2. Initialize using Azure AD authentication (see providers.tf).
3. Apply starting from resource group — resources deploy in strict dependency order.

## Azure Provider Constraints
- **Storage Account Name:** No hyphens, only lowercase alphanumeric, <=24 chars. **Azure constraint enforced in modules/storage_account and windows_virtual_machine; non-compliance produces validation errors during plan.**
- All other resources: Use hyphens as shown in naming patterns.

## NSG and Dependency Documentation
- NSG module depends on Subnet and Resource Group.
- Ensure deployment order: Resource Group → VNet → Subnet → NSG → Remaining Resources.
