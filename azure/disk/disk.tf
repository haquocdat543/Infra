resource "azurerm_managed_disk" "source" {
  name                 = "hqddisk"
  location             = azurerm_resource_group.example.location
  resource_group_name  = azurerm_resource_group.example.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "20"

  tags = {
    environment = "staging"
  }
}
