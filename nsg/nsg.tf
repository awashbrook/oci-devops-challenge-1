# NSGs for public subnet resource
resource "oci_core_network_security_group" "application_load_balancer_public_dmz_nsg" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "${var.app_tag}_${var.environment}_application_load_balancer_public_dmz_nsg"
}
resource "oci_core_network_security_group_security_rule" "application_load_balancer_public_dmz_nsg_rule" {
  network_security_group_id = oci_core_network_security_group.application_load_balancer_public_dmz_nsg.id
  direction                 = "INGRESS"
  protocol                  = "6" # TCP
  description               = "DMZ ingress from public internet into application compartment public load balancer"
  source                    = var.ingress_cidr_block
  source_type               = "CIDR_BLOCK"
  tcp_options {
    source_port_range {
      max = 80
      min = 80
    }
  }
}
resource "oci_core_network_security_group" "application_jump_box_public_dmz_nsg" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "${var.app_tag}_${var.environment}_application_jump_box_public_dmz_nsg"
}
resource "oci_core_network_security_group_security_rule" "application_jump_box_public_dmz_nsg_rule" {
  network_security_group_id = oci_core_network_security_group.application_jump_box_public_dmz_nsg.id
  direction                 = "INGRESS"
  protocol                  = "6" # TCP
  description               = "Jump box admin ingress from public internet into application compartment"
  source                    = var.ingress_cidr_block
  source_type               = "CIDR_BLOCK"
  tcp_options {
    source_port_range {
      max = 22
      min = 22
    }
  }
}
# NSGs for private subnet resource
resource "oci_core_network_security_group" "application_app_server_private_nsg" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "${var.app_tag}_${var.environment}_application_app_server_private_nsg"
}
resource "oci_core_network_security_group_security_rule" "application_app_server_loadbalancer_ingress" {
  network_security_group_id = oci_core_network_security_group.application_app_server_private_nsg.id
  direction                 = "INGRESS"
  protocol                  = "6" # TCP
  description               = "ingress from application compartment public load balancer into private app servers"
  source                    = oci_core_network_security_group.application_load_balancer_public_dmz_nsg.id
  source_type               = "NETWORK_SECURITY_GROUP"
  tcp_options {
    source_port_range {
      max = 8080
      min = 8080
    }
  }
}
resource "oci_core_network_security_group_security_rule" "application_app_server_bastion_ingress" {
  network_security_group_id = oci_core_network_security_group.application_app_server_private_nsg.id
  direction                 = "INGRESS"
  protocol                  = "6" # TCP
  description               = "Bastion admin ingress from public internet into application compartment"
  source                    = "172.168.0.0/16"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    source_port_range {
      max = 22
      min = 22
    }
  }
}


