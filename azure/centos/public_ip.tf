resource "azurerm_public_ip" "loadbalancer" {
  name                    = "loadbalancer"
  location                = azurerm_resource_group.example.location
  resource_group_name     = azurerm_resource_group.example.name
  allocation_method       = "Dynamic"

  tags = {
    environment = "test"
  }
}

resource "azurerm_public_ip" "master1" {
  name                    = "master1"
  location                = azurerm_resource_group.example.location
  resource_group_name     = azurerm_resource_group.example.name
  allocation_method       = "Dynamic"

  tags = {
    environment = "test"
  }
}

resource "azurerm_public_ip" "worker1" {
  name                    = "worker1"
  location                = azurerm_resource_group.example.location
  resource_group_name     = azurerm_resource_group.example.name
  allocation_method       = "Dynamic"

  tags = {
    environment = "test"
  }
}

