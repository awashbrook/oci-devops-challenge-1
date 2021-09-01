resource "oci_core_virtual_network" "base_vcn" {
  cidr_block     = var.vcn_cidr
  compartment_id = var.network_compartment_id
  dns_label      = lower(format("%s", var.app_tag))
  display_name   = "${var.app_tag}_${var.environment}_vcn"
}

resource "oci_core_internet_gateway" "base_ig" {
  vcn_id         = oci_core_virtual_network.base_vcn.id
  compartment_id = var.network_compartment_id
  display_name   = "${var.app_tag}_${var.environment}_internetgateway"
}