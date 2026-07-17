resource "azurerm_key_vault" "kv" {
  for_each = var.key_vaults
  name                = "${var.global.prefix}-${var.global.environment}-${each.value.name}"
  location            = each.value.location
  resource_group_name =  "${var.global.prefix}-${var.global.environment}-${each.value.resource_group_name}"
  tenant_id = each.value.tenant_id
  sku_name = "standard"
  purge_protection_enabled   = false
  soft_delete_retention_days = 7
   tags = merge(
    var.global.tags,
    {
      Environment = var.global.environment
      Resource    = "KeyVault"
    }
  )
}


#RBAC Role Assignment. This gives a user or Service Principal permission to manage secrets.
resource "azurerm_role_assignment" "rbac" {
  for_each = var.rbac_assignments
  scope = azurerm_key_vault.kv[each.value.key_vault_key].id
  role_definition_name = each.value.role_name
  principal_id = each.value.principal_id
}



resource "azurerm_key_vault_access_policy" "policy" {
  for_each = var.access_policies
  key_vault_id = azurerm_key_vault.kv[each.value.key_vault_key].id
  tenant_id = each.value.tenant_id
  object_id = each.value.object_id
  secret_permissions = each.value.secret_permissions
  key_permissions = each.value.key_permissions
  certificate_permissions = each.value.certificate_permissions
}

locals {
  secrets = flatten([
    for kv_key, kv in var.key_vaults : [
      for secret_name, secret_value in kv.secrets : {
        kv_key = kv_key
        name   = secret_name
        value  = secret_value
      }
    ]
  ])
}

resource "azurerm_key_vault_secret" "secret" {
  for_each = {
    for secret in local.secrets :
    "${secret.kv_key}-${secret.name}" => secret
  }
  name  = each.value.name
  value = each.value.value
  key_vault_id = azurerm_key_vault.kv[each.value.kv_key].id
  depends_on = [
    azurerm_role_assignment.rbac
  ]
}




