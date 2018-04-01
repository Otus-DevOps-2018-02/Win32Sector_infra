output "app_external_ip" {
  value = "${module.app.app_external_ip}"
}

#output "app_external_ip_reddit_app2" {
#  value = "${google_compute_instance.app.1.network_interface.0.access_config.0.assigned_nat_ip}"
#}
#output "load_balancer_ip" {
#  value = "${google_compute_forwarding_rule.default.ip_address}"
#}

