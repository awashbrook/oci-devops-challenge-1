# Regional public subnet, with no domain
resource "oci_core_subnet" "public" {
  vcn_id         = var.vcn_id
  cidr_block     = cidrsubnet(var.vcn_cidr, var.newbits, 0)
  compartment_id = var.compartment_id
  display_name   = "${var.app_tag}_${var.environment}_public_subnet"
}

# Regional private subnet, with no domain
resource "oci_core_subnet" "private" {
  vcn_id                     = var.vcn_id
  cidr_block                 = cidrsubnet(var.vcn_cidr, var.newbits, 1)
  compartment_id             = var.compartment_id
  display_name               = "${var.app_tag}_${var.environment}_private_subnet"
  prohibit_public_ip_on_vnic = true
}

