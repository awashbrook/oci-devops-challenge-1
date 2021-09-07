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
  # Default open egress rule everywhere 
  egress_security_rules {
    protocol    = var.all_protocols
    destination = var.anywhere
  }
  # Allow ssh ingress from Bastion VN
  ingress_security_rules {
    protocol    = var.tcp_protocol
    description = "Allow administration from Bastion VCN only"
    source      = var.bastion_vcn_cidr
    tcp_options {
      min = var.ssh_port
      max = var.ssh_port
    }
  }
  # ingress_security_rules {
  #   protocol    = var.tcp_protocol
  #   description = "Allow administration from anywhere from the public internet"
  #   source      = var.anywhere
  #   tcp_options {
  #     min = var.ssh_port
  #     max = var.ssh_port
  #   }
  # }
  ingress_security_rules {
    protocol    = var.icmp_protocol
    description = "Anybody can ping from the public internet"
    source      = var.anywhere
  }
  ingress_security_rules {
    protocol    = var.icmp_protocol
    description = "Anybody can ping from the application VCN "
    source      = var.vcn_cidr
  }
}