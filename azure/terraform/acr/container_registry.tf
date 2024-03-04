resource "azurerm_container_registry" "acr" {
  name                = "hqdAcr"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Premium"
  admin_enabled       = false
}
