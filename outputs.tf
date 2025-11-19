output "humanitec_metadata" {
  description = "Metadata for Humanitec."
  value = {
    "Kubernetes-Namespace"       = var.namespace
    "Kubernetes-Service-Account" = kubernetes_service_account_v1.sa.metadata[0].name
  }
}

output "name" {
  description = "The name of the service account"
  value       = var.name != null ? var.name : kubernetes_service_account_v1.sa.metadata[0].name
}
