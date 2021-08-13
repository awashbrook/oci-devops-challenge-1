resource "oci_core_virtual_network" "base_vcn" {
  cidr_block     = "${var.vcn_cidr}"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${var.app_tag}_${var.environment}_vcn"
  dns_label      = "${lower(format("%s", var.app_tag))}"
}

resource "oci_core_internet_gateway" "base_ig" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${var.app_tag}_${var.environment}_internetgateway"
  vcn_id         = "${oci_core_virtual_network.base_vcn.id}"
}
