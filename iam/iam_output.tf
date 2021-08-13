output "db_admins_id" {
  value = "${oci_identity_group.db_admins.id}"
}

output "iam_admin_managers_id" {
  value = "${oci_identity_group.iam_admin_managers.id}"
}

output "iam_managers_id" {
  value = "${oci_identity_group.iam_managers.id}"
}

output "net_sec_admins_id" {
  value = "${oci_identity_group.net_sec_admins.id}"
}

output "network_admins_id" {
  value = "${oci_identity_group.network_admins.id}"
}

output "read_only_id" {
  value = "${oci_identity_group.read_only.id}"
}

output "storage_admins_id" {
  value = "${oci_identity_group.storage_admins.id}"
}

output "sys_admins_id" {
  value = "${oci_identity_group.sys_admins.id}"
}