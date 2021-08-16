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

  app_tag     = var.app_tag
  environment = var.environment
  vcn_cidr    = var.vcn_cidr
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

module "application" {
  source                       = "./application"
  instance_availability_domain = "BofS:UK-LONDON-1-AD-1"
  instance_shape               = "VM.Standard.E2.1.Micro"
  compartment_ocid             = module.compartments.application_id
  subnet_id                    = module.vcn.application_private_subnet_id
  image_ocid                   = var.image_id[var.region]
  app_tag                      = var.app_tag
  environment                  = var.environment

  providers = {
    oci = oci
  }
}
