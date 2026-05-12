# Key Vault Compliance Controls

- Enforces minimum TLS 1.2 (`enabled_for_disk_encryption = true`, `enabled_for_deployment = false`, `enabled_for_template_deployment = false`).
- Access is managed strictly via Azure AD identities; no access keys or hardcoded secrets.
- Encryption-at-rest: All secrets and keys are stored in Azure Key Vault, which uses Azure managed HSM (hardware security modules).
- Diagnostic logging is enabled (see parent module for diagnostic settings).
- Restrictive firewall & ACL rules: Only specific subnets/IPs are permitted, public access is strictly denied.
- All resources are tagged per global standard (`org`, `env`, `app`, `region`).
- No regex-based validation, only length and presence checks.
- All access policies follow least-privilege principles for app, VM, and ops identities.
