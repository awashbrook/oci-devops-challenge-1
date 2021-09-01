module "compartments" {
  source       = "./compartments"
  tenancy_ocid = var.oci_devops_provider.tenancy_ocid
  app_tag      = var.oci_devops_general.app_tag
  environment  = var.oci_devops_general.environment
  providers = {
    oci = oci.home
  }
}
module "vcn_bastion" {
  source                 = "./vcn"
  tenancy_ocid           = var.oci_devops_provider.tenancy_ocid
  network_compartment_id = module.compartments.networks_id
  app_tag                = var.oci_devops_general.app_tag
  environment            = var.oci_devops_general.environment
  vcn_cidr               = var.vcn_cidr_bastion
}
module "vcn_application" {
  source                 = "./vcn"
  tenancy_ocid           = var.oci_devops_provider.tenancy_ocid
  network_compartment_id = module.compartments.networks_id
  app_tag                = var.oci_devops_general.app_tag
  environment            = var.oci_devops_general.environment
  vcn_cidr               = var.vcn_cidr_application
}
module "subnets_application" {
  source         = "./subnets"
  vcn_id         = module.vcn_application.vcn_id
  compartment_id = module.compartments.application_id
  vcn_cidr       = var.vcn_cidr_application
  newbits        = 8
  app_tag        = var.oci_devops_general.app_tag
  environment    = var.oci_devops_general.environment
}
module "iam" {
  source       = "./iam"
  tenancy_ocid = var.oci_devops_provider.tenancy_ocid
  app_tag      = var.oci_devops_general.app_tag
  environment  = var.oci_devops_general.environment
  providers = {
    oci = oci.home
  }
}
module "nsg" {
  source             = "./nsg"
  vcn_id             = module.vcn_application.vcn_id
  compartment_id     = module.compartments.application_id
  ingress_cidr_block = var.workstation_cidr
  app_tag            = var.oci_devops_general.app_tag
  environment        = var.oci_devops_general.environment
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
  app_tag                    = var.oci_devops_general.app_tag
  environment                = var.oci_devops_general.environment
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
  image_ocid                 = var.image_id[var.oci_devops_general.region]
  public_key                 = var.ssh_public_key
  app_tag                    = var.oci_devops_general.app_tag
  environment                = var.oci_devops_general.environment
  providers = {
    oci = oci
  }
}
module "bastion" {
  source  = "oracle-terraform-modules/bastion/oci"
  version = "2.1.0"

  # provider identity parameters
  api_fingerprint      = var.oci_devops_provider.api_fingerprint
  api_private_key_path = var.oci_devops_provider.api_private_key_path
  region               = var.oci_devops_provider.region
  tenancy_id           = var.oci_devops_provider.tenancy_id
  user_id              = var.oci_devops_provider.user_id

  # general oci parameters
  compartment_id = var.oci_devops_general.compartment_id
  label_prefix   = var.oci_devops_general.label_prefix

  # network parameters

  availability_domain = var.oci_devops_bastion.availability_domain
  bastion_access      = var.oci_devops_bastion.bastion_access
  ig_route_id         = module.vcn.ig_route_id
  netnum              = var.oci_devops_bastion.netnum
  newbits             = var.oci_devops_bastion.newbits
  vcn_id              = module.vcn.vcn_id

  # bastion parameters
  bastion_enabled                  = var.oci_devops_bastion.bastion_enabled
  bastion_image_id                 = var.oci_devops_bastion.bastion_image_id
  bastion_operating_system_version = var.oci_devops_bastion.bastion_operating_system_version
  bastion_shape                    = var.oci_devops_bastion.bastion_shape
  bastion_state                    = var.oci_devops_bastion.bastion_state
  bastion_upgrade                  = var.oci_devops_bastion.bastion_upgrade
  ssh_public_key                   = var.oci_devops_bastion.ssh_public_key
  ssh_public_key_path              = var.oci_devops_bastion.ssh_public_key_path
  timezone                         = var.oci_devops_bastion.timezone

  # notification
  notification_enabled  = var.oci_devops_bastion.notification_enabled
  notification_endpoint = var.oci_devops_bastion.notification_endpoint
  notification_protocol = var.oci_devops_bastion.notification_protocol
  notification_topic    = var.oci_devops_bastion.notification_topic

  # tags
  tags = var.oci_devops_bastion.tags
}
