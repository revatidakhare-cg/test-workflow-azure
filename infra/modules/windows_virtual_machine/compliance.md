# Compliance Controls for cg-prod-mstcls-vm-wus2-001

## Encryption
- OS/Data disks require Azure-managed encryption at rest (default).  
- Storage account for boot diagnostics and VM extensions must enforce encryption.

## Networking & Isolation
- NSG rules implemented to restrict inbound traffic:
  - **RDP (3389) is denied from all sources except trusted admin subnets.**
  - **Only HTTP (80) allowed from App Service subnet.**
  - **All other inbound traffic denied.**
- No wildcard (0.0.0.0/0) allowed for RDP.

## Identity & Access Management
- No hardcoded credentials; credentials provisioned via Key Vault.
- Only identity-based authentication for Azure RM backend.

## Logging & Monitoring
- VM must enable diagnostic logging to a compliant storage account.
- Minimum TLS version enforced (1.2+).

## Tagging
- All resources tagged with org, env, app, region, owner, compliance.

## Platform Version & Syntax
- Strict enforcement: Terraform 1.14.8 - see versions.tf for required_version constraint.

## Resource Naming
- Naming pattern enforced: `{org}-{env}-{app}-vm-{region}-{seq}` ⇒ cg-prod-mstcls-vm-wus2-001
- Storage Account naming validated to meet Azure length and character limits (lowercase alphanumeric, max 24 chars).

## Further Observations
- No regex validation, only length or non-empty checks used for input validation.
- Outputs only defined in outputs.tf, never main.tf or other files.