# Storage Account Compliance Implementation

This module enforces strict security and compliance requirements for production storage accounts:

## Encryption-at-Rest
- Storage is always encrypted at rest using Microsoft-managed keys or, optionally, customer-managed keys (CMK).

## Network Access & Firewall Rules
- Public network access is blocked for all services; default action is `Deny`.
- Only explicitly allowed VNets and subnets (via `allowed_subnet_ids`) can access the storage account.
- No public IP rules are configured; open access (0.0.0.0/0) is strictly forbidden.

## TLS & Secure Transfer Requirements
- Enforces minimum TLS 1.2 for all connections (`minimum_tls_version` and `enable_https_traffic_only` must be set at the resource level in main.tf).
- Disables blob public access.

## Diagnostic Logging
- Diagnostic logging and threat monitoring must be configured by the parent infrastructure. Logging settings are not repeated in this module to avoid conflict with centralized policy.

## Tagging
- All storage accounts must be tagged according to organizational policy: `org`, `env`, `app`, `region`, and additional tags as required.

## No Hardcoded Secrets
- No credentials or access keys are hardcoded or output from this module. All secrets are stored in Azure Key Vault.

## Regulatory Alignment
- Restricts configuration to best practices for SOC2, ISO 27001, and CIS Azure Foundations Benchmark v1.5:
  - Least privilege network rules
  - Data-at-rest encryption
  - Mandatory secure TLS transport
  - Diagnostic logging and audit trail (must be implemented at parent/root module)

---
For details on compliance controls, see: [Microsoft Azure Storage Regulatory Compliance](https://learn.microsoft.com/en-us/azure/storage/common/storage-compliance-controls)
