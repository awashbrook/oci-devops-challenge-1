resource "oci_core_virtual_network" "vcn" {
  cidr_block     = var.vcn_cidr
  compartment_id = var.network_compartment_id
  dns_label      = lower(format("%s", var.app_tag))
  display_name   = "${var.app_tag}_${var.environment}_vcn"
}

resource "oci_core_internet_gateway" "vcn_ig" {
  vcn_id         = oci_core_virtual_network.vcn.id
  compartment_id = var.network_compartment_id
  display_name   = "${var.app_tag}_${var.environment}_internetgateway"
}

resource "oci_core_local_peering_gateway" "vcn_lpg" {
  vcn_id         = oci_core_virtual_network.vcn.id
  compartment_id = var.network_compartment_id
  display_name   = "${var.app_tag}_${var.environment}_localpeeringgateway"
}

resource "oci_core_default_security_list" "peering-vcns" {
  manage_default_resource_id = oci_core_virtual_network.vcn.default_security_list_id
  # TODO Kill this if this isnt default egress rules
  egress_security_rules {
    protocol    = var.all_protocols
    destination = var.anywhere
  }
  # Allow ssh ingress from Bastion
  ingress_security_rules {
    protocol    = var.tcp_protocol
    description = "Bastion admin ingress from public internet into application compartment"
    source      = var.bastion_vcn_cidr
    tcp_options {
      min = var.ssh_port
      max = var.ssh_port
    }
  }
}