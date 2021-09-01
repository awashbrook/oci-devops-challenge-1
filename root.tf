module "compartments" {
  source       = "./compartments"
  tenancy_ocid = var.tenancy_ocid
  app_tag      = var.app_tag
  environment  = var.environment
  providers = {
    oci = oci.home
  }
}
module "vcn_bastion" {
  source                 = "./vcn"
  tenancy_ocid           = var.tenancy_ocid
  network_compartment_id = module.compartments.networks_id
  app_tag                = var.app_tag
  environment            = var.environment
  vcn_cidr               = "172.168.0.0/16"
}
module "vcn_application" {
  source                 = "./vcn"
  tenancy_ocid           = var.tenancy_ocid
  network_compartment_id = module.compartments.networks_id
  app_tag                = var.app_tag
  environment            = var.environment
  vcn_cidr               = "10.0.0.0/16"
}
module "subnets_application" {
  source         = "./subnets"
  vcn_id         = module.vcn_application.vcn_id
  compartment_id = module.compartments.application_id
  app_tag        = var.app_tag
  environment    = var.environment
  # TODO CIDR
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
module "nsg" {
  source             = "./nsg"
  vcn_id             = module.vcn_application.vcn_id
  compartment_id     = module.compartments.application_id
  ingress_cidr_block = var.workstation_cidr
  app_tag            = var.app_tag
  environment        = var.environment
  providers = {
    oci = oci
  }
}
module "loadbalancer" {
  source                     = "./loadbalancer"
  is_public_ip               = "true"
  compartment_id             = module.compartments.application_id
  subnet_id                  = module.subnets_application.public_subnet_id
  network_security_group_ids = [module.nsg.application_load_balancer_public_dmz_nsg_id]
  backend_ip_address         = module.application.instance_private_ip
  shape                      = var.loadbalancer_shape
  app_tag                    = var.app_tag
  environment                = var.environment
  providers = {
    oci = oci
  }
}
module "application" {
  source                     = "./application"
  is_public_ip               = "false"
  availability_domain        = var.availability_domain
  shape                      = var.instance_shape
  compartment_id             = module.compartments.application_id
  subnet_id                  = module.subnets_application.private_subnet_id
  network_security_group_ids = [module.nsg.application_public_application_app_server_private_nsg_id]
  cloud_init                 = data.template_cloudinit_config.cloudinit-app-server.rendered
  image_ocid                 = var.image_id[var.region]
  public_key                 = var.ssh_public_key
  app_tag                    = var.app_tag
  environment                = var.environment
  providers = {
    oci = oci
  }
}
