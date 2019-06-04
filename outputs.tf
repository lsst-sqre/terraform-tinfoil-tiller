output "namespace" {
  description = "kubernetes namespace in which tiller is installed"
  sensitive   = false
  value       = "${var.namespace}"
}

output "service_account" {
  description = "name of kubernetes service account for tiller"
  sensitive   = false
  value       = "${var.service_account}"
}
