data "azurerm_application_security_group" "pks-master-asg" {
  name                = var.master_asg
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_interface_application_security_group_association" "pks-nic-asg-assoc" {
  count                         = length(var.master_nics)
  network_interface_id          = data.azurerm_network_interface.pks-master-nics[count.index].id
  application_security_group_id = data.azurerm_application_security_group.pks-master-asg.id
}
