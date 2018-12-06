output "namespace" {
  sensitive = false
  value     = "${var.namespace}"
}

output "service_account" {
  sensitive = false
  value     = "${var.service_account}"
}
