variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "private_key_password" {}
variable "app_tag" {}
variable "environment" {}
variable "home_region" {}
variable "region" {}
variable "vcn_cidr" {
  default = "10.0.0.0/16"
}
