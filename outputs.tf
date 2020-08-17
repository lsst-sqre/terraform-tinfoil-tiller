output "namespace" {
  description = "kubernetes namespace in which tiller is installed"
  sensitive   = false
  value       = kubernetes_deployment.tiller_deploy.metadata[0].namespace
}

output "service_account" {
  description = "name of kubernetes service account for tiller"
  sensitive   = false
  value       = kubernetes_deployment.tiller_deploy.spec[0].template[0].spec[0].service_account_name
}
