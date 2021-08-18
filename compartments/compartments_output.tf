output "networks_id" {
  value = oci_identity_compartment.networks.id
}

output "bastion_id" {
  value = oci_identity_compartment.bastion.id
}

output "shared_services_id" {
  value = oci_identity_compartment.shared_services.id
}

output "application_id" {
  value = oci_identity_compartment.application.id
}
