variable "tenancy_ocid" {}
variable "vcn_cidr" {}
variable "network_compartment_id" {}
variable "app_tag" {}
variable "environment" {}
variable "bastion_vcn_cidr" {
  default = "172.168.0.0/16"
}

variable "icmp_protocol" {
  default = 1
}
variable "tcp_protocol" {
  default = 6
}
variable "all_protocols" {
  default = "all"
}
variable "anywhere" {
  default = "0.0.0.0/0"
}
variable "ssh_port" {
  default = "22"
}