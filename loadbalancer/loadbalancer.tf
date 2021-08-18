resource "oci_load_balancer" "loadbalancer" {
  display_name               = "${var.app_tag}_${var.environment}_loadbalancer"
  compartment_id             = var.compartment_id
  shape                      = var.shape
  subnet_ids                 = [var.subnet_id]                # TBD
  network_security_group_ids = var.network_security_group_ids # TBD
  is_private                 = !var.is_public_ip
}
resource "oci_load_balancer_listener" "loadbalancer_listener" {
  default_backend_set_name = oci_load_balancer_backend_set.loadbalancer_backend_set.name
  load_balancer_id         = oci_load_balancer.loadbalancer.id
  name                     = "http-listener"
  port                     = 80
  protocol                 = "HTTP"
}
resource "oci_load_balancer_backend_set" "loadbalancer_backend_set" {
  load_balancer_id = oci_load_balancer.loadbalancer.id
  name             = "app-servers"
  policy           = "LEAST_CONNECTIONS"
  health_checker {
    port     = 80
    protocol = "TCP"
    # TODO Implement health check app servers
    # protocol = "HTTP"
    # url_path = "TBD"
  }
}
resource "oci_load_balancer_backend" "loadbalancer_backend" {
  #Required
  backendset_name  = oci_load_balancer_backend_set.loadbalancer_backend_set.name
  ip_address       = var.backend_ip_address
  load_balancer_id = oci_load_balancer.loadbalancer.id
  port             = 8080
  #Optional
  # backup = var.backend_backup
  # drain = var.backend_drain
}