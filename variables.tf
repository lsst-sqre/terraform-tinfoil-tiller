variable "namespace" {
  description = "kubernetes namespace to deploy into"
  default     = "kube-system"
}

variable "service_account" {
  description = "kubernetes service account name"
  default     = "tiller"
}

variable "tiller_image" {
  description = "tiller docker image."
  default     = "gcr.io/kubernetes-helm/tiller:v2.11.0"
}
