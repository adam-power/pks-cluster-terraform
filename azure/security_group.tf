data "azurerm_application_security_group" "pks-master-asg" {
  count               = var.master_asg == "" ? 0 : 1
  name                = var.master_asg
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_interface_application_security_group_association" "pks-nic-asg-assoc" {
  count                         = var.master_asg == "" ? 0 : length(var.master_nics)
  network_interface_id          = data.azurerm_network_interface.pks-master-nics[count.index].id
  application_security_group_id = data.azurerm_application_security_group.pks-master-asg[0].id
}
