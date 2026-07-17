# create virtual n/w
resource "azurerm_virtual_network" "vnet" {
  for_each            = var.virtual_networks
  name                = "${var.global.prefix}-${var.global.environment}-${each.value.name}"
  location            = each.value.location
  resource_group_name = "${var.global.prefix}-${var.global.environment}-${each.value.resource_group}"
  address_space       = each.value.address_space
  tags = merge(
    var.global.tags,
    {
      Environment = var.global.environment
      Resource    = "VirtualNetwork"
    }
  )
}

# create sub-nets
resource "azurerm_subnet" "subnet" {
  for_each             = var.subnets
  name                 = each.value.name
  resource_group_name  = "${var.global.prefix}-${var.global.environment}-${each.value.resource_group_name}"
  virtual_network_name = "${var.global.prefix}-${var.global.environment}-${each.value.virtual_network_name}"
  address_prefixes     = each.value.address_prefixes
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}


# create NSG's
resource "azurerm_network_security_group" "nsg" {
  for_each            = var.network_security_groups
  name                = "${var.global.prefix}-${var.global.environment}-${each.value.name}"
  location            = each.value.location
  resource_group_name = "${var.global.prefix}-${var.global.environment}-${each.value.resource_group_name}"
  tags = merge(
    var.global.tags,
    {
      Environment = var.global.environment
      Resource    = "NSG"
    }
  )
}

# Associate NSG with Subnet => make the relation
resource "azurerm_subnet_network_security_group_association" "association" {
  for_each                  = var.subnets
  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}