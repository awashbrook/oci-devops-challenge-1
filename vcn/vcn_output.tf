output "vcn_id" {
  value = oci_core_virtual_network.base_vcn.id
}
output "default_dhcp_id" {
  value = oci_core_virtual_network.base_vcn.default_dhcp_options_id
}
output "internet_gateway_id" {
  value = oci_core_internet_gateway.base_ig.id
}
output "public_subnet_id" {
  value = oci_core_subnet.public.id
}
output "private_subnet_id" {
  value = oci_core_subnet.private.id
}