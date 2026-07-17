variable "key_vaults" {
  type = map(any)
}


variable "rbac_assignments" {
  type = map(object({
    key_vault_key = string
    principal_id = string
    role_name = string
  }))
  default = {}
}


variable "access_policies" {
  type = map(object({
    key_vault_key = string
    tenant_id = string
    object_id = string
    secret_permissions = list(string)
    key_permissions = list(string)
    certificate_permissions = list(string)
  }))
  default = {}
}


variable "global" {
  type = object({
    prefix      = string
    environment = string
    tags        = map(string)
  })
}