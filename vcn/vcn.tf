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