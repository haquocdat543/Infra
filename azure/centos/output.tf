output "loadbalancer" {
  value = azurerm_linux_virtual_machine.loadbalancer.public_ip_address
}

output "master1" {
  value = azurerm_linux_virtual_machine.master1.public_ip_address
}

output "worker1" {
  value = azurerm_linux_virtual_machine.worker1.public_ip_address
}

