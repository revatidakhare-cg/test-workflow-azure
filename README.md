# CI/CD Pipeline for Terraform on Azure (GitHub Actions)

This repository contains a production-grade CI/CD setup for deploying Azure infrastructure using Terraform, with GitHub Actions and OpenID Connect (OIDC) for secure authentication.

- Integration: GitHub Actions
- Cloud provider: Azure
- IaC: Terraform
- Terraform version: 1.14.7
- Default branch: `main`

## Repository Structure

- `.github/workflows/deploy.yml` – CI/CD pipeline
- `infra/main.tf` – Terraform configuration
- `README.md` – Documentation

## Prerequisites

1. **Azure Subscription** with permission to create:
   - Resource groups
   - Storage accounts
2. **GitHub Repository** with:
   - Default branch: `main`
   - Admin access to configure secrets and environments
3. **Tools (for local development)**
   - Terraform 1.14.7
   - Azure CLI (optional but recommended)

## Azure OIDC Setup (Federated Credentials)

The pipeline uses GitHub OIDC to authenticate to Azure without storing long-lived credentials.

### 1. Create an Azure AD Application (Service Principal)

Use Azure CLI (replace placeholders as needed):

```bash
SUBSCRIPTION_ID="<your-subscription-id>"
AZURE_AD_APP_NAME="github-oidc-terraform-sp"

az account set --subscription "$SUBSCRIPTION_ID"

# Create the app registration
APP_ID=$(az ad app create \
  --display-name "$AZURE_AD_APP_NAME" \
  --query appId -o tsv)

# Create a service principal for the app
az ad sp create --id "$APP_ID"

# Assign a role (example: Contributor) at subscription scope
az role assignment create \
  --assignee "$APP_ID" \
  --role "Contributor" \
  --scope "/subscriptions/$SUBSCRIPTION_ID"

echo "APP_ID: $APP_ID"
```

Note the following values:
- `APP_ID` → used as `AZURE_CLIENT_ID`
- Your tenant ID → `AZURE_TENANT_ID` (can be obtained via `az account show --query tenantId -o tsv`)
- `SUBSCRIPTION_ID` → `AZURE_SUBSCRIPTION_ID`

### 2. Configure Federated Credentials for GitHub

1. Go to **Azure Portal → Microsoft Entra ID → App registrations**.
2. Open the app you created (`github-oidc-terraform-sp`).
3. Go to **Certificates & secrets → Federated credentials → Add credential**. (with enviernment - production)
5. Configure:
   - **Federated credential scenario**: `GitHub Actions deploying Azure resources` (if available) or `Other issuer`.
   - **Issuer**: `https://token.actions.githubusercontent.com`
   - **Subject identifier** (for repository-level access on `main` branch):
     - Format: `repo:<org-or-user>/<repo-name>:ref:refs/heads/main`
   - **Audience**: `api://AzureADTokenExchange` (default for Azure).

This allows workflows in the specified repository and branch to obtain tokens for the app using OIDC.

## GitHub Secrets Configuration

In your GitHub repository:

1. Go to **Settings → Secrets and variables → Actions → Secrets**.
2. Add these repository secrets:

- `AZURE_CLIENT_ID` – `APP_ID` of your Azure AD application
- `AZURE_TENANT_ID` – Tenant ID of your Azure AD
- `AZURE_SUBSCRIPTION_ID` – Azure subscription ID

The workflow uses these secrets with `azure/login@v2` and OIDC.

## Terraform Configuration (infra/main.tf)

`infra/main.tf` contains a minimal Azure setup:

- Pins Terraform version to `1.14.7`:
  ```hcl
  terraform {
    required_version = "= 1.14.7"
  }
  ```
- Configures the `azurerm` provider.
- Creates:
  - A resource group
  - A storage account
- Exposes outputs:
  - `resource_group_name`
  - `storage_account_id`

You can customize:

- `var.location` (default: `eastus`)
- `var.resource_group_name`
- `var.storage_account_name` (must be globally unique and lowercase, 3–24 chars)

## GitHub Actions Workflow Overview

Workflow file: `.github/workflows/deploy.yml`

### Triggers

- `push` to `main` affecting:
  - `.github/workflows/deploy.yml`
  - `infra/**`
  - `README.md`
- `pull_request` targeting `main` affecting `infra/**`
- `workflow_dispatch` (manual run)

### Jobs

1. **validate**
   - Checks out code.
   - Installs Terraform `1.14.7`.
   - Runs `terraform init` and `terraform validate` in `infra/`.

2. **plan** (depends on `validate`)
   - Logs into Azure via OIDC using `azure/login@v2`.
   - Runs `terraform init`.
   - Runs `terraform plan -out=tfplan.out`.
   - Shows the plan.
   - Calculates whether there are changes (`plan_has_changes` output).
   - Uploads `tfplan.out` as an artifact.

3. **apply** (depends on `plan`)
   - Runs only when:
     - Branch is `main` (`github.ref == 'refs/heads/main'`), and
     - The plan detected changes (`plan_has_changes == 'true'`).
   - Uses `production` environment (you can add manual approval to this environment in GitHub settings if desired).
   - Logs into Azure via OIDC.
   - Downloads the saved `tfplan.out` artifact.
   - Re-runs `terraform init`.
   - Executes `terraform apply tfplan.out`.

This ensures that `apply` always corresponds exactly to the previously generated plan.

## How to Use the Pipeline

### 1. Initial Setup

1. Complete Azure OIDC setup (service principal + federated credentials).
2. Add GitHub secrets: `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID`.
3. Push the repository contents to the `main` branch.

### 2. Running Locally (Optional)

Install Terraform 1.14.7 and Azure CLI.

```bash
cd infra
terraform init
terraform plan
terraform apply
```

To authenticate locally with Azure CLI:

```bash
az login
az account set --subscription "<your-subscription-id>"
```

### 3. CI/CD Flow

- **Pull Requests to `main`**
  - Run `validate` and `plan` jobs.
  - You can inspect the plan output in the Actions logs.
  - `apply` does not run for PRs.

- **Pushes to `main`**
  - Run `validate` → `plan` → `apply` (if there are changes).
  - Plan is stored as an artifact and then applied.

- **Manual Run**
  - Go to **Actions → CI/CD - Terraform Azure → Run workflow**.
  - Select the `main` branch and run.

## Customization

- **Change Terraform resources**
  - Edit `infra/main.tf` to add or modify resources.

- **Variables and remote state**
  - Introduce `terraform.tfvars` or environment variables for configuration.
  - For production use, consider configuring a remote backend (e.g., Azure Storage) in the `terraform` block.

- **Environment approvals**
  - In GitHub: **Settings → Environments → New environment → production**.
  - Add required reviewers to gate the `apply` step.

## Troubleshooting

- **OIDC login failures**
  - Verify federated credential subject matches exactly: `repo:<org>/<repo>:ref:refs/heads/main`.
  - Ensure `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID` are correct.

- **Terraform version mismatch**
  - Ensure local Terraform is `1.14.7`.
  - Confirm `TF_VERSION` in the workflow and `required_version` in `main.tf` are `= 1.14.7`.

- **Storage account name errors**
  - Must be globally unique, 3–24 characters, lowercase letters and numbers only.
  - Adjust `var.storage_account_name` in `infra/main.tf` or via `terraform.tfvars`.

This setup provides a secure, reproducible CI/CD pipeline for managing Azure infrastructure with Terraform using GitHub Actions and OIDC-based authentication.
