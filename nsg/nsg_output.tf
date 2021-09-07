output "application_load_balancer_public_dmz_nsg_id" {
  value = oci_core_network_security_group.application_load_balancer_public_dmz_nsg.id
}
output "application_jump_box_public_dmz_nsg_id" {
  value = oci_core_network_security_group.application_jump_box_public_dmz_nsg.id
}
output "application_app_server_private_nsg_id" {
  value = oci_core_network_security_group.application_app_server_private_nsg.id
}

 