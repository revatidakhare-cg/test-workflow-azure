# terraform.tfvars
org        = "cg"
env        = "prod"
app        = "mstcls"
region     = "wus2"
resource_group_name = "cg-prod-mstcls-rg-wus2"
location   = "West US 2"
# IMPORTANT: Replace with your actual Azure subscription ID
subscription_id = "0d889837-de09-496c-bea5-710d433e75c5"
tags = {
  environment = "prod"
  project     = "cloudboost"
  owner       = "cg"
}
windows_vm_admin_username = "cgadmin"
# Key Vault secret referencing for admin_password (do not hardcode)
windows_vm_admin_password_secret_uri = "https://cg-prod-mstcls-keyvault-wus2-001.vault.azure.net/secrets/windowsvm-admin-password"
# Admin password for initial Key Vault setup - CHANGE THIS IMMEDIATELY
windows_vm_admin_password = "ChangeMe123!@#"

# Required Azure AD values - MUST be updated with actual values
tenant_id         = "0c3223d1-a9b0-4b67-ad95-0c87153dd862"  # Replace with your actual tenant ID
ad_admin_object_id = "4f54b523-729a-4941-8c30-2a396f45ed89" # Replace with your actual admin object ID

# VM configuration
vm_size        = "Standard_DS2_v2"
image_publisher = "MicrosoftWindowsServer"
image_offer     = "WindowsServer"
image_sku       = "2022-datacenter"

# Network configuration
trusted_admin_subnets = []
app_service_subnets   = []
