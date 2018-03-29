
resource "google_compute_target_pool" "default" {
  name = "instance-pool"

  instances = [
    "${var.zone}/reddit-app",
    "${var.zone}/reddit-app2",
  ]

  health_checks = [
    "${google_compute_http_health_check.health_check_reddit_app.name}",
  ]
}
resource "google_compute_http_health_check" "health_check_reddit_app" {
  name               = "healthcheck"
  request_path       = "/"
  check_interval_sec = 1
  timeout_sec        = 1
  port               = 9292
}
resource "google_compute_forwarding_rule" "default" {
  name       = "website-forwarding-rule"
  target     = "${google_compute_target_pool.default.self_link}"
  port_range = "9292"
}
