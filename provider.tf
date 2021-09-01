provider "oci" {
  alias                = "home"
  tenancy_ocid         = var.oci_devops_provider.tenancy_ocid
  user_ocid            = var.oci_devops_provider.user_ocid
  fingerprint          = var.oci_devops_provider.fingerprint
  private_key_path     = var.oci_devops_provider.private_key_path
  private_key_password = var.oci_devops_provider.private_key_password
  region               = var.oci_devops_general.home_region
}
provider "oci" {
  tenancy_ocid         = var.oci_devops_provider.tenancy_ocid
  user_ocid            = var.oci_devops_provider.user_ocid
  fingerprint          = var.oci_devops_provider.fingerprint
  private_key_path     = var.oci_devops_provider.private_key_path
  private_key_password = var.oci_devops_provider.private_key_password
  region               = var.oci_devops_general.region
}