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

# TODO Refactor the subnets

# # Bastion public subnet 
# resource "oci_core_subnet" "bastion_public" {
#   vcn_id         = "${oci_core_virtual_network.base_vcn.id}"
#   cidr_block     = "172.168.1.0/29"
#   compartment_id = "${var.bastion_compartment_id}"
#   availability_domain = ""
#   display_name   = "${var.app_tag}_${var.environment}_public_subnet"  
# }

# Regional public subnet, with no domain
resource "oci_core_subnet" "public" {
  vcn_id         = oci_core_virtual_network.base_vcn.id
  cidr_block     = "10.0.1.0/24"
  compartment_id = var.compartment_id
  display_name   = "${var.app_tag}_${var.environment}_public_subnet"
}

# Regional private subnet, with no domain
resource "oci_core_subnet" "private" {
  vcn_id                     = oci_core_virtual_network.base_vcn.id
  cidr_block                 = "10.0.2.0/24"
  compartment_id             = var.compartment_id
  display_name               = "${var.app_tag}_${var.environment}_private_subnet"
  prohibit_public_ip_on_vnic = true
}

