provider "azurerm" {
	  version = "~> 1.27"
}

resource "azurerm_resource_group" "resg" {
  name     = "terraform-group"
  location = "${var.location}"
  tags     = "${var.tags}"
}

resource "azurerm_application_insights" "ai" {
  name                = "terraform-ai"
  resource_group_name = "${azurerm_resource_group.resg.name}"
  location            = "${azurerm_resource_group.resg.location}"
  application_type    = "Web"
  tags                = "${var.tags}"
}

resource "azurerm_app_service_plan" "appsvcplan" {
  name                = "terraform-app-svc-plan"
  resource_group_name = "${azurerm_resource_group.resg.name}"
  location            = "${azurerm_resource_group.resg.location}"
  kind                = "${var.appservice_plan_kind}"
  reserved            = true
  tags                = "${var.tags}"

  sku {
    tier = "${var.appservice_plan_tier}"
    size = "${var.appservice_plan_size}"
  }
}

resource "azurerm_app_service" "appsvc" {
  name                = "terraform-app-linux-app-svc"
  resource_group_name = "${azurerm_resource_group.resg.name}"
  app_service_plan_id = "${azurerm_app_service_plan.appsvcplan.id}"
  location            = "${azurerm_resource_group.resg.location}"
  tags                = "${var.tags}"

	  app_settings = {
	  WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
	}

  site_config {
		#always_on        = "${var.appservice_docker_image}"
    linux_fx_version = "DOCKER|${var.appservice_docker_image}"
  }
}
