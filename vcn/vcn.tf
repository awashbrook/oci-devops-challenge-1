resource "oci_core_virtual_network" "base_vcn" {
  cidr_block     = "${var.vcn_cidr}"
  compartment_id = "${var.compartment_ocid}"
  dns_label      = "${lower(format("%s", var.app_tag))}"
  display_name   = "${var.app_tag}_${var.environment}_vcn"
}

resource "oci_core_internet_gateway" "base_ig" {
  vcn_id         = "${oci_core_virtual_network.base_vcn.id}"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${var.app_tag}_${var.environment}_internetgateway"
}

# Application Regional public subnet, with no domain
resource "oci_core_subnet" "public_subnet" {
  vcn_id         = "${oci_core_virtual_network.base_vcn.id}"
  cidr_block     = "10.0.0.0/24"
  compartment_id = "${var.application_compartment_ocid}"
  display_name   = "${var.app_tag}_${var.environment}_public_subnet"  
}