resource "oci_core_instance" "app_server" {
  availability_domain = var.instance_availability_domain
  compartment_id = var.compartment_ocid
  shape = var.instance_shape
  
  source_details {
    source_id = var.image_ocid
    source_type = "image"
  }
  create_vnic_details {
    subnet_id = var.subnet_id
  }
}