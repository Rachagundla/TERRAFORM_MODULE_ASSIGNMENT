resource "azurerm_service_plan" "plan" {

  for_each = var.app_service_plans

  name                = "${var.global.prefix}-${var.global.environment}-${each.key}"
  resource_group_name =  "${var.global.prefix}-${var.global.environment}-${each.value.resource_group_name}"
  location            = each.value.location

  os_type  = each.value.os_type
  sku_name = each.value.sku_name

    tags = merge(
    var.global.tags,
    {
      Environment = var.global.environment
    }
  )
}


resource "azurerm_windows_web_app" "webapp" {

  for_each = var.web_apps

  name                = "${var.global.prefix}-${var.global.environment}-${each.value.name}"
  location            = each.value.location
  resource_group_name =  "${var.global.prefix}-${var.global.environment}-${each.value.resource_group_name}"

  service_plan_id = azurerm_service_plan.plan[each.value.plan_name].id

   tags = merge(
    var.global.tags,
    {
      Environment = var.global.environment
    }
  )

  site_config {
    always_on = false
    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v8.0"
    }
  }

}