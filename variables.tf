variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "private_key_password" {}

# Free Tier
variable "loadbalancer_shape" {
  default = "10Mbps-Micro"
}
variable "instance_shape" {
  default = "VM.Standard.E2.1.Micro"
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
variable "app_tag" {}
variable "environment" {}
variable "home_region" {}
variable "region" {}
variable "availability_domain" {
  default = "BofS:UK-LONDON-1-AD-1"
}
variable "workstation_cidr" {}
