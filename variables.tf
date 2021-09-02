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

variable "oci_devops_bastion" {
  type = object({
    availability_domain              = number
    bastion_access                   = string
    bastion_enabled                  = bool
    bastion_image_id                 = string
    bastion_operating_system_version = string
    bastion_shape                    = map(any)
    bastion_state                    = string
    bastion_upgrade                  = bool
    netnum                           = number
    newbits                          = number
    notification_enabled             = bool
    notification_endpoint            = string
    notification_protocol            = string
    notification_topic               = string
    ssh_private_key_path             = string
    ssh_public_key                   = string
    ssh_public_key_path              = string
    label_prefix                     = string
    tags                             = map(any)
    timezone                         = string
  })
  description = "bastion host parameters"
  default = {
    availability_domain              = 1
    bastion_access                   = "ANYWHERE"
    bastion_enabled                  = false
    bastion_image_id                 = "Autonomous"
    bastion_operating_system_version = "7.9"
    bastion_shape = {
      # shape = "VM.Standard.E2.2"
      shape            = "VM.Standard.E3.Flex",
      ocpus            = 1,
      memory           = 4,
      boot_volume_size = 50
    }
    bastion_state   = "RUNNING"
    bastion_upgrade = true

    netnum                = 0
    newbits               = 14
    notification_enabled  = false
    notification_endpoint = ""
    notification_protocol = "EMAIL"
    notification_topic    = "bastion"
    ssh_private_key_path  = ""
    ssh_public_key        = ""
    ssh_public_key_path   = ""
    label_prefix          = ""
    tags = {
      role = "bastion"
    }
    timezone = "Australia/Sydney"
  }
}
