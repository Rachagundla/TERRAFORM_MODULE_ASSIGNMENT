
# declaring the values for dev - different resources
global = {
  prefix      = "abc"
  environment = "dev"
  tags = {
    Project   = "Terraform Assignment"
    Owner     = "Pavan"
    ManagedBy = "Terraform"
  }
}

resource_groups = {
  rg1 = {
    name     = "rg1"
    location = "Central India"
    tags = {}
  }

  rg2 = {
    name     = "rg2"
    location = "Central India"
    tags = {}
  }

  rg3 = {
    name     = "rg3"
    location = "Central India"
    tags = {}
  }
}


# declaring Vnet, Subnet, Nsg's for dev resources
virtual_networks = {
  network = {
    name = "vnet"
    location = "Central India"
    resource_group = "rg1"
    address_space = ["10.0.0.0/16"]
  }
}
subnets = {
  network = {
    name = "frontend"
    virtual_network_name = "vnet"
    resource_group_name = "rg1"
    address_prefixes = ["10.0.1.0/24"]
  }
}
network_security_groups = {
  network = {
    name = "nsg"
    location = "Central India"
    resource_group_name = "rg1"
  }
}



storage_accounts = {
  storage1 = {
    name = "storage001"
    resource_group_name = "rg1"
    location = "Central India"
    account_tier = "Standard"
    account_replication_type = "LRS"
    containers = [
      "images",
      "documents",
      "logs"
    ]
  }

  storage2 = {
    name = "storage002"
    resource_group_name = "rg1"
    location = "Central India"
    account_tier = "Standard"
    account_replication_type = "GRS"
    containers = [
      "backup",
      "terraform"
    ]
  }
}


# keyvaults, RBAC assignments, and access policies for dev environment
key_vaults = {
  kv1 = {
    name                = "kv1"
    resource_group_name = "rg1"
    location            = "Central India"
    tenant_id           = "a32338c0-8892-4dd8-bfec-ad4f7d5b40a1"

    secrets = {
      PostgreSQLAdmin    = "dbadmin"
      PostgreSQLPassword = "Password@123"
      StorageKey         = "storage123"
    }
  }
}

rbac_assignments = {
  developer = {
    key_vault_key = "kv1"
    principal_id = "bc073855-a47c-408f-94c9-69f7fbd0f915"
    role_name = "Key Vault Secrets Officer"
  }

  admin = {
    key_vault_key = "kv1"
    principal_id = "bc073855-a47c-408f-94c9-69f7fbd0f915"
    role_name = "Key Vault Administrator"
  }

}

access_policies = {

  developer = {
    key_vault_key = "kv1"
    tenant_id = "a32338c0-8892-4dd8-bfec-ad4f7d5b40a1"
    object_id = "bc073855-a47c-408f-94c9-69f7fbd0f915"
    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete"
    ]
    key_permissions = [
      "Get",
      "List"
    ]
    certificate_permissions = [
      "Get",
      "List"
    ]
  }

}

app_service_plans = {
  plan1 = {
    resource_group_name = "rg1"
    location = "Central India"
    sku_name = "B1"
    os_type = "Windows"
  }
}
web_apps = {
  app1 = {
    name = "webapp001"
    resource_group_name = "rg1"
    location = "Central India"
    plan_name = "plan1"
  }
  app2 = {
    name = "webapp002"
    resource_group_name = "rg1"
    location = "Central India"
    plan_name = "plan1"
  }
}