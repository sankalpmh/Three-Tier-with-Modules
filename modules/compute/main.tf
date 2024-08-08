# Availability Set for Web VMs
resource "azurerm_availability_set" "web_availability_set" {
  name                = "web_availability_set"
  location            = var.location
  resource_group_name = var.resource_group
}

# Public IP for Web VM 1
resource "azurerm_public_ip" "web_public_ip_1" {
  name                = "web-public-ip-1"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Dynamic"
}

# Network Interface for Web VM 1
resource "azurerm_network_interface" "web_net_interface_1" {
  name                = "web-network-1"
  resource_group_name = var.resource_group
  location            = var.location

  ip_configuration {
    name                          = "web-webserver-1"
    subnet_id                     = var.web_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web_public_ip_1.id
  }
}

# Public IP for Web VM 2
resource "azurerm_public_ip" "web_public_ip_2" {
  name                = "web-public-ip-2"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Dynamic"
}

# Network Interface for Web VM 2
resource "azurerm_network_interface" "web_net_interface_2" {
  name                = "web-network-2"
  resource_group_name = var.resource_group
  location            = var.location

  ip_configuration {
    name                          = "web-webserver-2"
    subnet_id                     = var.web_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web_public_ip_2.id
  }
}

resource "azurerm_virtual_machine" "web_vm_1" {
  name                = "web-vm-1"
  location            = var.location
  resource_group_name = var.resource_group
  network_interface_ids = [azurerm_network_interface.web_net_interface_1.id]
  availability_set_id = azurerm_availability_set.web_availability_set.id
  vm_size             = "Standard_DS1_v2"
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  storage_os_disk {
    name              = "web-disk-1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.web_host_name_1
    admin_username = var.web_username
    admin_password = var.web_os_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_virtual_machine" "web_vm_2" {
  name                = "web-vm-2"
  location            = var.location
  resource_group_name = var.resource_group
  network_interface_ids = [azurerm_network_interface.web_net_interface_2.id]
  availability_set_id = azurerm_availability_set.web_availability_set.id
  vm_size             = "Standard_DS1_v2"
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  storage_os_disk {
    name              = "web-disk-2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.web_host_name_2
    admin_username = var.web_username
    admin_password = var.web_os_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# Availability Set for App VMs (unchanged)
resource "azurerm_availability_set" "app_availability_set" {
  name                = "app_availability_set"
  location            = var.location
  resource_group_name = var.resource_group
}

# Network Interface for App VM (unchanged)
resource "azurerm_network_interface" "app_net_interface" {
  name                = "app-network"
  resource_group_name = var.resource_group
  location            = var.location

  ip_configuration {
    name                          = "app-webserver"
    subnet_id                     = var.app_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

# App VM (unchanged)
resource "azurerm_virtual_machine" "app_vm" {
  name                = "app-vm"
  location            = var.location
  resource_group_name = var.resource_group
  network_interface_ids = [azurerm_network_interface.app_net_interface.id]
  availability_set_id = azurerm_availability_set.app_availability_set.id
  vm_size             = "Standard_DS1_v2"
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  storage_os_disk {
    name              = "app-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.app_host_name
    admin_username = var.app_username
    admin_password = var.app_os_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
