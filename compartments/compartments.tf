resource "oci_identity_compartment" "networks" {
  description = "The networks compartment"
  name        = "${var.app_tag}_${var.environment}_networks"
}

resource "oci_identity_compartment" "bastion" {
  description = "The bastion compartment"
  name        = "${var.app_tag}_${var.environment}_bastion"
}

resource "oci_identity_compartment" "shared_services" {
  description = "The shared_services compartment"
  name        = "${var.app_tag}_${var.environment}_shared_services"
}

resource "oci_identity_compartment" "application" {
  description = "The application compartment"
  name        = "${var.app_tag}_${var.environment}_application"
}
