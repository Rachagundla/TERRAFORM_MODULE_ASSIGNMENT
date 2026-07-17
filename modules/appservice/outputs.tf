output "app_service_plan_ids" {
  value = {
    for k, v in azurerm_service_plan.plan :
    k => v.id
  }
}

output "web_app_urls" {
  value = {
    for k, v in azurerm_windows_web_app.webapp :
    k => v.default_hostname
  }
}