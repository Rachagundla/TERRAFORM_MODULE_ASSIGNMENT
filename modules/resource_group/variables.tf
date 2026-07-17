variable "global" {
  type = object({
    prefix      = string
    environment = string
    tags        = map(string)
  })
}

variable "resource_groups" {
  description = "Map of Resource Groups"

  type = map(object({
    name     = string
    location = string
    tags      = map(string)
  }))
}

