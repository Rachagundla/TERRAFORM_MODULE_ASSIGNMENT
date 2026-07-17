module "resource_group" {
  source          = "./modules/resource_group"
  resource_groups = var.resource_groups # Notice that no Azure resource is created directly in the root.
  global          = var.global
}

module "network" {
  source                  = "./modules/network"
  global                  = var.global
  virtual_networks        = var.virtual_networks
  subnets                 = var.subnets
  network_security_groups = var.network_security_groups
}

module "storage" {
  source           = "./modules/storage"
  global           = var.global
  storage_accounts = var.storage_accounts
}


module "keyvault" {
  source           = "./modules/keyvault"
  global           = var.global
  key_vaults       = var.key_vaults
  rbac_assignments = var.rbac_assignments
  access_policies  = var.access_policies
}


module "appservice" {
  source            = "./modules/appservice"
  global            = var.global
  app_service_plans = var.app_service_plans
  web_apps          = var.web_apps
}




