output "appservice_dns_name" {
  value = "${azurerm_app_service.appsvc.default_site_hostname}"
}
