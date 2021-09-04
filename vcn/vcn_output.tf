output "vcn_id" {
  value = oci_core_virtual_network.vcn.id
}
output "internet_gateway_id" {
  value = oci_core_internet_gateway.vcn_ig.id
}