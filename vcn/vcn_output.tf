output "vcn_id" {
  value = oci_core_virtual_network.vcn.id
}
output "internet_gateway_id" {
  value = oci_core_internet_gateway.vcn_ig.id
}
output "local_peering_gateway" {
  value = oci_core_local_peering_gateway.vcn_lpg.id
}