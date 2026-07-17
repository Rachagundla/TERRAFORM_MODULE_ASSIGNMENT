output "storage_account_ids" {
  value = {
    for key, value in azurerm_storage_account.storage :
    key => value.id
  }
}

output "storage_account_names" {
  value = {
    for key, value in azurerm_storage_account.storage :
    key => value.name
  }
}

output "container_names" {
  value = {
    for key, value in azurerm_storage_container.container :
    key => value.name
  }
}