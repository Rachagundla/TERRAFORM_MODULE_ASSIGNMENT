variable "app_service_plans" {
  type = map(object({
    resource_group_name = string
    location            = string
    sku_name            = string
    os_type             = string
  }))
}

variable "web_apps" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    plan_name           = string
  }))
}

variable "global" {
  type = object({
    prefix      = string
    environment = string
    tags        = map(string)
  })
}