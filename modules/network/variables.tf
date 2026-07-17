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
  description = "NSGs"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
  }))
}

variable "global" {
  type = object({
    prefix      = string
    environment = string
    tags        = map(string)
  })
}