resource "azurerm_kubernetes_cluster" "example" {
  name                = "flux"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "hqd_public_"
  automatic_channel_upgrade = "stable"

  default_node_pool {
    name       = "first"
    node_count = 3
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}
