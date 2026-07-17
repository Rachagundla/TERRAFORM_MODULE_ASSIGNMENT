variable "storage_accounts" {

  description = "Storage Account Configuration"
  type = map(object({
    name                     = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string
    containers = list(string)
  }))
}

variable "global" {
  type = object({
    prefix      = string
    environment = string
    tags        = map(string)
  })
}