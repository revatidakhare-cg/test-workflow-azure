# Resource Group Module Instantiation
module "resource_group" {
  source   = "./modules/resource_group"
  org      = var.org
  env      = var.env
  app      = var.app
  region   = var.region
  tags     = var.tags
}

# Instantiate Virtual Network (Depends on RG)
module "virtual_network" {
  source                    = "./modules/virtual_network"
  resource_group_name       = module.resource_group.name
  location                  = var.location
  tags                      = var.tags
  org                       = var.org
  env                       = var.env
  app                       = var.app
  region                    = var.region
  address_space             = ["10.0.0.0/16"]
  default_subnet_prefixes   = ["10.0.1.0/24"]
  depends_on                = [module.resource_group]
}

# Subnet module (Depends on VNet and RG)
module "subnet" {
  source              = "./modules/subnet"
  resource_group_name = module.resource_group.name
  virtual_network_id  = module.virtual_network.id
  location            = var.location
  org                 = var.org
  env                 = var.env
  app                 = var.app
  region              = var.region
  nseq                = 1
  depends_on          = [module.virtual_network]
}

# NSG module (Depends on Subnet and RG)
module "nsg" {
  source              = "./modules/nsg"
  resource_group_name = module.resource_group.name
  subnet_id           = module.subnet.id
  location            = var.location
  org                 = var.org
  env                 = var.env
  app                 = var.app
  region              = var.region
  nseq                = 1
  depends_on          = [module.subnet]
}

# Instantiate Storage Account (for state and module usage; Depends on RG and NSG)
module "storage_account" {
  source                    = "./modules/storage_account"
  resource_group_name       = module.resource_group.name
  location                  = var.location
  tags                      = var.tags
  org                       = var.org
  env                       = var.env
  app                       = var.app
  region                    = var.region
  storage_account_sequence  = "001"
  depends_on                = [module.resource_group, module.nsg]
}

# Instantiate Key Vault, explicit depends_on for NSG for security ordering
module "key_vault" {
  source                           = "./modules/key_vault"
  resource_group_name              = module.resource_group.name
  location                         = var.location
  tags                             = var.tags
  key_vault_name                   = format("%s-%s-%s-kv-%s", var.org, var.env, var.app, var.region)
  tenant_id                        = var.tenant_id
  admin_object_id                  = var.ad_admin_object_id
  admin_password                   = var.windows_vm_admin_password
  diagnostic_storage_account_id    = module.storage_account.id
  allowed_ip_ranges                = []
  allowed_subnet_ids               = [module.subnet.id]
  depends_on                       = [module.storage_account, module.nsg]
}

# Instantiate App Service, explicit depends_on for NSG for security ordering
module "app_service" {
  source                  = "./modules/app_service"
  resource_group_name     = module.resource_group.name
  location                = var.location
  tags                    = var.tags
  org                     = var.org
  env                     = var.env
  app                     = var.app
  region                  = var.region
  storage_account_name    = module.storage_account.name
  key_vault_name          = module.key_vault.key_vault_name
  tenant_id               = var.tenant_id
  network_dependency      = [module.virtual_network, module.subnet]
  depends_on              = [module.key_vault, module.storage_account, module.nsg]
}

# Instantiate Windows Virtual Machine
module "windows_vm" {
  source                        = "./modules/windows_virtual_machine"
  resource_group_name           = module.resource_group.name
  location                      = var.location
  tags                          = var.tags
  org                           = var.org
  env                           = var.env
  app                           = var.app
  region                        = var.region
  subnet_id                     = module.subnet.id
  nsg_id                        = module.nsg.id
  keyvault_id                   = module.key_vault.key_vault_id
  admin_username                = var.windows_vm_admin_username
  admin_password_secret_uri      = var.windows_vm_admin_password_secret_uri
  trusted_admin_subnets         = var.trusted_admin_subnets
  app_service_subnets           = var.app_service_subnets
  vm_size                       = var.vm_size
  tenant_id                     = var.tenant_id
  ad_admin_object_id            = var.ad_admin_object_id
  image_publisher               = var.image_publisher
  image_offer                   = var.image_offer
  image_sku                     = var.image_sku
  depends_on                    = [module.virtual_network, module.key_vault, module.storage_account, module.nsg]
}
