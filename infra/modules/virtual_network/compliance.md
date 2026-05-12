# Compliance: Virtual Network

## Standards
- All network traffic is restricted to explicitly defined trusted sources.
- Only subnets required for dependent resources are provisioned.
- No default "allow all" rules. Ingress/Egress must be least-privilege.
- Diagnostic logs for flow, routes, and NSG audits are enabled via network watcher and exported to a secure Storage Account.
- Resource and subnet names comply with accepted conventions and Azure resource limits.
- Tags: organization, environment, application, and region are set as per policy.
- Azure Policy: Only TLS 1.2 connections permitted for peered services where applicable.

## Encryption
- All diagnostic data in transit and at rest uses encryption (TLS 1.2+, AES256).

## Change Management
- All changes must be tracked in Terraform state and versioned.
- Resource re-creation IMPOSES downtime—coordinate carefully.

## Auditing
- NSG flow logging is enabled per subnet.
- If changes occur to the network rules, alerting is defined via Azure Monitor (external to this module).

## Approval
- All VNet/subnet boundary changes require security review before deployment in production.

---
