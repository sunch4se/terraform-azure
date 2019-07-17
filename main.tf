provider "azurerm" {
  version = "~> 1.27"
}

resource "azurerm_resource_group" "resg" {
  name     = "terraform-group"
  location = "${var.location}"
  tags     = "${var.tags}"
}
