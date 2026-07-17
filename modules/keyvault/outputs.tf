output "key_vault_ids" {
  value = {
    for key, value in azurerm_key_vault.kv :
    key => value.id
  }
}

output "key_vault_names" {
  value = {
    for key, value in azurerm_key_vault.kv :
    key => value.name
  }
}