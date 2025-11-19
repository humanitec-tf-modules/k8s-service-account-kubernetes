resource "kubernetes_service_account_v1" "sa" {
  metadata {
    annotations   = var.additional_annotations
    labels        = var.additional_labels
    name          = var.name
    generate_name = var.name_prefix
    namespace =  var.namespace
  }
  automount_service_account_token = var.automount_service_account_token
}
