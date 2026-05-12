# App Service Compliance Summary

## Policies Enforced
- **TLS Minimum Version**: TLS 1.2 required for all connections to the App Service, enforced at both service and storage-diagnostic layers.
- **Encryption at Rest**: All diagnostics logs and app configuration are stored in Azure Storage Accounts using server-side encryption (default, with minimum TLS1_2) as required by Azure security standards.
- **Identity-based Authentication**: Azure AD identities are used and enforced for management and backend access without storage account keys in code.
- **Restrictive Network Access**: The App Service is made accessible only through a Private Endpoint. No public inbound traffic is permitted; enforced via subnet-level NSG rules.
- **Diagnostic Logging**: All application logs, HTTP logs, and metrics are audited and stored in a secure storage account with encrypted transit and storage.

## Compliance Controls
- Service-level security policies (TLS, HTTPS, certificate enforcement) are managed explicitly.
- Diagnostic logging is always enabled and output is encrypted.
- NSG applies whitelist rules for Private Endpoint only; all other inbound traffic is denied.
- Strict naming conventions and resource tags (org, env, app, region, etc.) are applied to all resources for traceability.

## Reference Standards
- Azure CIS Benchmark v1.5
- NIST 800-53: SC-13, SC-8, AU-2, AU-6
- PCI DSS v3.2.1: 2.2.2, 4.1
- GDPR Article 32: Security of Processing

## Auditing
- All required diagnostic categories are enabled and sent to encrypted storage.
- Enforced by Terraform resource implementation and Azure platform controls.
