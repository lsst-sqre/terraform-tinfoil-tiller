variable "namespace" {
  description = "kubernetes namespace to deploy into"
  default     = "kube-system"
}

variable "service_account" {
  description = "kubernetes service account name"
  default     = "tiller"
}
