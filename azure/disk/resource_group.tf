# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East Asia"
}
