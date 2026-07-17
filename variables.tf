# The root variables validate the user's input before passing it to the module.
# The module variables validate that the module is always called correctly, even if another project uses it.
# So there are two validation layers.





variable "resource_groups" {
  description = "Resource Groups"
  type = map(object({
    name     = string
    location = string
    tags     = map(string)
  }))
}


# Below variables having only field this also works by passing any key-value pair, but terraform doesnot catch
# With map(any), Terraform accepts almost anything.Terraform won't catch the mistake until much later.
# variable "virtual_networks" {
#   type = map(any)
# }
# variable "subnets" {
#   type = map(any)
# }
# variable "network_security_groups" {
#   type = map(any)
# }





variable "virtual_networks" {
  description = "Virtual Networks"
  type = map(object({
    name           = string
    location       = string
    resource_group = string
    address_space  = list(string)
  }))
}

variable "subnets" {
  description = "Subnets"
  type = map(object({
    name                 = string
    virtual_network_name = string
    resource_group_name  = string
    address_prefixes     = list(string)
  }))
}


variable "network_security_groups" {
  description = "Network Security Groups"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
  }))
}



variable "storage_accounts" {
  description = "Storage Accounts"
  type = map(object({
    name                     = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string
    containers               = list(string)
  }))
}


variable "app_service_plans" {
  description = "App Service Plans"
  type = map(object({
    resource_group_name = string
    location            = string
    sku_name            = string
    os_type             = string
  }))
}

variable "web_apps" {
  description = "Windows Web Apps"
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    plan_name           = string
  }))
}


# The below variable is used to create Key Vaults, RBAC assignments, and access policies. 
# It is defined as a map of any type to allow flexibility in the structure of the input data. 
# This allows users to define multiple key vaults with different configurations, as well as RBAC assignments and access policies for each key vault.
variable "key_vaults" {
  type = map(any)
}

variable "rbac_assignments" {
  type = map(any)
}

variable "access_policies" {
  type = map(any)
}

# This varibale is responsible for selecting the environment to deploy. It is used in the backend configuration to select the correct state file.
variable "global" {
  description = "Global configuration"
  type = object({
    prefix      = string # company name they used mostly
    environment = string
    tags        = map(string)
  })
}