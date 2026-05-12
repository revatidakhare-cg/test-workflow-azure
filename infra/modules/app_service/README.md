# App Service (Production)

This module provisions a highly secure, production-grade Azure App Service instance, adhering to strict organizational naming and security standards.

## Features
- Enforces strict naming: `{org}-{env}-{app}-app-{region}-{seq}`
- Requires resource group, location, org, env, app, region parameters
- Secure configuration: HTTPS only, minimum TLS 1.2
- Diagnostic logging enabled
- Tagging and resource compliance

## Variables
| Name                | Description                         | Type    | Required |
|---------------------|-------------------------------------|---------|----------|
| resource_group_name | Name of the Azure Resource Group    | string  | yes      |
| location            | Azure region for deployment         | string  | yes      |
| org                 | Organization code                   | string  | yes      |
| env                 | Environment (e.g., prod)            | string  | yes      |
| app                 | Application abbreviation            | string  | yes      |
| region              | Azure region code                   | string  | yes      |
| tags                | Resource tags                       | map     | no       |

## Outputs
- `app_service_name`: The name of the deployed App Service.
- `app_service_id`: Resource ID of the App Service.

## Compliance
- TLS minimum 1.2 enforced
- Diagnostic logging enabled for App Service
- Encrypted data at rest managed by Azure
- No hardcoded secrets

---
*Strict naming, security, and compliance enforced to meet organization and regulatory standards.*
