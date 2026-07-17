output "vnet_ids" {
  value = {
    for key, value in azurerm_virtual_network.vnet :
    key => value.id
  }
}

output "subnet_ids" {
  value = {
    for key, value in azurerm_subnet.subnet :
    key => value.id
  }
}

output "nsg_ids" {
  value = {
    for key, value in azurerm_network_security_group.nsg :
    key => value.id
  }
}