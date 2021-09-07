variable "oci_devops_provider" {
  type = object({
    api_fingerprint          = string
    api_private_key_path     = string
    api_private_key_password = string
    region                   = string
    tenancy_id               = string
    user_id                  = string
  })
  description = "oci provider parameters"
}
variable "oci_devops_general" {
  type = object({
    home_region = string
    region      = string
    app_tag     = string
    environment = string
  })
  description = "general oci parameters"
}
# TODO Free Tier Forever Shapes
variable "loadbalancer_shape" {
  default = "10Mbps-Micro"
}
variable "instance_shape" {
  default = "VM.Standard.E2.1.Micro"
  # default = "VM.Standard.E2.2" # Not Free Tier
}

variable "instance_username" {
  default = "opc"
}
variable "image_id" {
  type = map(string)
  default = {
    // See https://docs.cloud.oracle.com/iaas/images/ 
    // Oracle-provided image "Oracle-Linux-7.9-2021.07.27-0"
    uk-london-1 = "ocid1.image.oc1.uk-london-1.aaaaaaaa646hmq7yvlxk6wqhdzrljfxdy7iyy6wk7xtmdf3x73ko45nwqfsa"
  }
}
variable "ssh_public_key" {}
variable "availability_domain" {
  default = "BofS:UK-LONDON-1-AD-1"
}
variable "vcn_cidr_application" {
  default = "10.0.0.0/16"
}
variable "vcn_cidr_bastion" {
  default = "172.168.0.0/16"
}
variable "workstation_cidr" {}

