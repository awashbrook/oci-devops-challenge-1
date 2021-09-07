output "instance_id" {
  value = oci_core_instance.app_server.id
}
output "instance_private_ip" {
  value = oci_core_instance.app_server.private_ip
}
