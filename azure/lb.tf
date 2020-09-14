resource "azurerm_public_ip" "pks-cluster-ip" {
  name                = "${var.cluster_name}-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "pks-cluster-lb" {
  name                = "${var.cluster_name}-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.pks-cluster-ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "pks-cluster-backend-pool" {
  name                = "${var.cluster_name}-backend-pool"
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.pks-cluster-lb.id
}

resource "azurerm_lb_rule" "pks-cluster-lb-rule" {
  name                           = "${var.cluster_name}-lb-rule"
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.pks-cluster-lb.id
  probe_id                       = azurerm_lb_probe.pks-cluster-probe.id
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.pks-cluster-backend-pool.id
  protocol                       = "Tcp"
  frontend_port                  = 8443
  backend_port                   = 8443
}

resource "azurerm_lb_probe" "pks-cluster-probe" {
  name                = "${var.cluster_name}-probe"
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.pks-cluster-lb.id
  protocol            = "Tcp"
  port                = 8443
}

data "azurerm_network_interface" "pks-master-nics" {
  count               = length(var.master_nics)
  name                = var.master_nics[count.index]
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_interface_backend_address_pool_association" "pks-nic-pool-assoc" {
  count                   = length(var.master_nics)
  network_interface_id    = data.azurerm_network_interface.pks-master-nics[count.index].id
  ip_configuration_name   = "ipconfig0"
  backend_address_pool_id = azurerm_lb_backend_address_pool.pks-cluster-backend-pool.id
}
