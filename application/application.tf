resource "oci_core_instance" "app_server" {
  display_name        = "${var.app_tag}_${var.environment}_app_server"
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  shape               = var.shape

  source_details {
    source_id   = var.image_ocid
    source_type = "image"
  }
  create_vnic_details {
    subnet_id        = var.subnet_id
    assign_public_ip = var.is_public_ip
    nsg_ids          = var.network_security_group_ids
  }

  extended_metadata = { "ssh_authorized_keys" : var.public_key, "user_data" : var.cloud_init }
}