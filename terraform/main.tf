resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}
resource "azurerm_storage_account" "storage" {
  name                = var.storage_account_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  allow_nested_items_to_be_public = false

  tags = {
    Project = "Azure Terraform GitHub Actions"
    Owner   = "Tolu D"
    Environment = "Dev"
    ManagedBy = "Terraform"   
  }
}

# Create a Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-portfolio-prod"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create a Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create a Network Interface Card (NIC)
resource "azurerm_network_interface" "nic" {
  name                = "nic-portfolio-prod"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create a Minimal Linux VM (Standard_B1ls is the cheapest size, ~£3/month)
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "demo-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B1ls" # Minimal size
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  # Generate a dummy password for testing (use SSH keys in production!)
  admin_password                  = "Portfoliopasswd123!"
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}
