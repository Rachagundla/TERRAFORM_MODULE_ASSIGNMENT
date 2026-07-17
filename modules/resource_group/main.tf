resource "azurerm_resource_group" "rg" {
  for_each = var.resource_groups
  name     = "${var.global.prefix}-${var.global.environment}-${each.value.name}"
  location = each.value.location
  tags = merge(
    var.global.tags,
    each.value.tags,
    {
      Environment = var.global.environment
    })
}