variable "workstation_cidr" {}
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "image_id" {
  type = map(string)
  default = {
    // See https://docs.cloud.oracle.com/iaas/images/ 
    // Oracle-provided image "Oracle-Linux-7.4-2018.02.21-1"
    us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaaapqrkiqsuj2yxoypb26z6k4wt47fhynnr36zyhdn6to26fd4l54q"
    us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaajlpkjb5lpw36fx2nsxmw7cxle2r5ox7wtj3wcgnvviih6p725jba"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaayaoazkfukf2ug7adabq5nb2dmyu45s6zpwwky7pd5aegqepj45ba"
    uk-london-1 = "ocid1.image.oc1.uk-london-1.aaaaaaaak2aelt2ihexd23lcfwq6fert3nbufv3tphgmpxeczdwmrgpcklga"
  }
}
variable "private_key_path" {}
variable "private_key_password" {}
variable "instance_username" {
 default = "opc"
}
variable "ssh_private_key_path" {}
variable "ssh_public_key_path" {}
variable "app_tag" {}
variable "environment" {}
variable "home_region" {}
variable "region" {}
variable "vcn_cidr" {
  default = "10.0.0.0/16"
}
