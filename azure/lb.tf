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
