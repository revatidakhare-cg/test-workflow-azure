# Basic Example: Azure Production Deployment (cg-cloudboost-mstcls-prod-wus2)

This example demonstrates a complete, secure, and production-ready deployment of core Azure resources using strictly enforced naming conventions, execution order, compliance, and Terraform v1.14.8 standards.

## Resources Provisioned
- Windows Virtual Machine (1)
- App Service (1)
- Virtual Network (1)
- Storage Account (1)
- Key Vault (1)

## Naming Convention
All resources follow the pattern:
- Windows VM: `cg-prod-mstcls-vm-wus2-001`
- App Service: `cg-prod-mstcls-app-wus2-001`
- Virtual Network: `cg-prod-mstcls-vnet-wus2-001`
- Storage Account: `cgprodmstclsstoragewus2001` (24 chars max, all lowercase)
- Key Vault: `cg-prod-mstcls-keyvault-wus2-001`

## Terraform Version & Compatibility
- **Requires Terraform v1.14.8** (enforced in root `versions.tf`).
- Fully compatible with AzureRM provider.

## Secure Infrastructure Practices
- Identity-based authentication to Azure.
- No hardcoded secrets; passwords/keys stored in Key Vault.
- Minimum TLS 1.2 enforced, encryption at rest enabled.
- Strict network and firewall restrictions (no open 0.0.0.0/0).
- Diagnostic logging enabled.
- Comprehensive tagging for each resource.

## Usage
1. Ensure Terraform v1.14.8 is installed ([official guide](https://developer.hashicorp.com/terraform/install)).
2. Supply required variables in `terraform.tfvars` (see root README).
3. Deploy resources via:
   ```sh
   terraform init
   terraform apply
   ```

## Outputs
Refer to `outputs.tf` for exported resource IDs:
- `windows_virtual_machine_id`
- `app_service_id`
- `virtual_network_id`
- `storage_account_id`
- `key_vault_id`

## Compliance & Best Practices
- All outputs are globally unique.
- No duplication or cross-file conflicts.
- No regex-based validation used; only safe length/non-empty checks.
- Resource names and outputs strictly respect provider limits.

---
**Organization:** cg  |  **Project:** cloudboost-mstcls  |  **Environment:** prod  |  **Region:** wus2

For detailed module usage, variable definition, and customization, see root documentation and module README files.
