terraform {
  # Remote backend configuration for Azure Storage (production)
  # backend "azurerm" {
  #   resource_group_name  = "cg-prod-mstcls-rg-wus2"
  #   storage_account_name = "cgprodmstclsstgwus01"
  #   container_name       = "tfstate"
  #   key                  = "prod/terraform.tfstate"
  #   use_azuread_auth     = true
  # }

  # Local backend for development
  # To use remote backend, comment out the local backend and uncomment the azurerm backend above
}

