resource "azurerm_dns_a_record" "pks-cluster-dns" {
  name                = var.cluster_name
  zone_name           = var.dns_zone_name
  resource_group_name = var.dns_zone_resource_group_name
  ttl                 = 300
  target_resource_id  = azurerm_public_ip.pks-cluster-ip.id
}
