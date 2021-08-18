module "compartments" {
  source       = "./compartments"
  tenancy_ocid = var.tenancy_ocid
  app_tag      = var.app_tag
  environment  = var.environment
  providers = {
    oci = oci.home
  }
}
module "vcn" {
  source                       = "./vcn"
  tenancy_ocid                 = var.tenancy_ocid
  compartment_ocid             = module.compartments.networks_id
  application_compartment_ocid = module.compartments.application_id
  bastion_compartment_ocid     = module.compartments.bastion_id
  app_tag                      = var.app_tag
  environment                  = var.environment
  vcn_cidr                     = var.vcn_cidr
}
module "iam" {
  source       = "./iam"
  tenancy_ocid = var.tenancy_ocid
  app_tag      = var.app_tag
  environment  = var.environment
  providers = {
    oci = oci.home
  }
}
module "loadbalancer" {
  source                     = "./loadbalancer"
  availability_domain        = "BofS:UK-LONDON-1-AD-1"
  shape                      = "10Mbps-Micro" # Free Tier
  compartment_ocid           = module.compartments.application_id
  subnet_id                  = module.vcn.application_public_subnet_id
  network_security_group_ids = []
  is_public_ip               = "true"
  backend_ip_address         = module.application.instance_private_ip
  app_tag                    = var.app_tag
  environment                = var.environment
  providers = {
    oci = oci
  }
}
module "application" {
  source                     = "./application"
  availability_domain        = "BofS:UK-LONDON-1-AD-1"
  shape                      = "VM.Standard.E2.1.Micro" # Free Tier
  compartment_ocid           = module.compartments.application_id
  subnet_id                  = module.vcn.application_private_subnet_id
  network_security_group_ids = []
  is_public_ip               = "false"
  cloud_init                 = data.template_cloudinit_config.cloudinit-app-server.rendered
  image_ocid                 = var.image_id[var.region]
  public_key                 = var.ssh_public_key
  app_tag                    = var.app_tag
  environment                = var.environment
  providers = {
    oci = oci
  }
}
