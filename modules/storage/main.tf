resource "azurerm_storage_account" "storage" {
  for_each = var.storage_accounts
   name = lower(replace(
    "${var.global.prefix}${var.global.environment}${each.value.name}",
    "-",
    ""
  ))
 resource_group_name = "${var.global.prefix}-${var.global.environment}-${each.value.resource_group_name}"
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
  tags = merge(
    var.global.tags,
    {
      Environment = var.global.environment
      Resource    = "StorageAccount"
    }
  )
}

# flaten the container
locals {
  containers = flatten([
    for storage_key, storage in var.storage_accounts : [
      for container in storage.containers : {
        storage_key = storage_key
        name        = container
      }
    ]
  ])
}


# create blob containers
resource "azurerm_storage_container" "container" {
  for_each = {
    for container in local.containers :
    "${container.storage_key}-${container.name}" => container
  }
  name = each.value.name
  storage_account_id = azurerm_storage_account.storage[each.value.storage_key].id
  container_access_type = "private"
}