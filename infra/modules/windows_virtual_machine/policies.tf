# POLICIES for production-grade security & compliance
# Enforce encryption at rest, minimum TLS, diagnostic logging, and identity-based access.
# These policies are for documentation and must be implemented via Azure Policy Assignment (not in Terraform resource).

locals {
  compliance_policies = {
    "encryption_at_rest"         = "VM disks and OS disks MUST be encrypted with Azure-managed keys."
    "tls_minimum_1_2"            = "All VM endpoints MUST enforce TLS >= 1.2 for inbound connections."
    "diagnostic_logging"         = "VM must have Azure Diagnostics enabled and logs stored in Storage Account."
    "identity_based_access"      = "Access to VM should be performed using Azure AD identities. Avoid local admin logins."
    "resource_tagging"           = "All VM resources MUST be tagged with org, env, app, region, and contact."
    "restrictive_nsg_rules"      = "Only allow inbound traffic from approved IP ranges. Deny 0.0.0.0/0 for RDP."
    "key_vault_password_storage" = "Admin credentials MUST be stored/retrieved from Key Vault (NEVER hardcoded)."
  }
}
