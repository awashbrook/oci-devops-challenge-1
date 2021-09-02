provider "oci" {
  alias                = "home"
  tenancy_ocid         = var.oci_devops_provider.tenancy_id
  user_ocid            = var.oci_devops_provider.user_id
  fingerprint          = var.oci_devops_provider.api_fingerprint
  private_key_password = var.oci_devops_provider.api_private_key_path
  private_key_path     = var.oci_devops_provider.api_private_key_password
  region               = var.oci_devops_general.home_region
}
provider "oci" {
  tenancy_ocid         = var.oci_devops_provider.tenancy_id
  user_ocid            = var.oci_devops_provider.user_id
  fingerprint          = var.oci_devops_provider.api_fingerprint
  private_key_password = var.oci_devops_provider.api_private_key_path
  private_key_path     = var.oci_devops_provider.api_private_key_password
  region               = var.oci_devops_general.region
}