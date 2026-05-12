module "key_vault" {
  source                  = "../../modules/key_vault"
  resource_group_name     = var.resource_group_name
  location                = var.location
  tags                    = var.tags
  org                     = var.org
  env                     = var.env
  app                     = var.app
  region                  = var.region
  kv_seq                  = var.kv_seq
  keyvault_access_policies = var.keyvault_access_policies
  vnet_id                 = var.vnet_id
  subnet_id               = var.subnet_id
}
