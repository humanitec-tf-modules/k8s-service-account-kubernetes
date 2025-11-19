resource "kubernetes_service_account_v1" "sa" {
  metadata {
    annotations   = var.additional_annotations
    labels        = var.additional_labels
    name          = var.name
    generate_name = var.name == null ? var.name_prefix : null
    namespace     = var.namespace
  }
  automount_service_account_token = var.automount_service_account_token
}

resource "kubernetes_role_binding_v1" "rb" {
  for_each = toset(var.roles)

  metadata {
    generate_name = "${kubernetes_service_account_v1.sa.metadata[0].name}-bind-"
    namespace     = var.namespace
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = each.key
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.sa.metadata[0].name
    namespace = var.namespace
  }
}

resource "kubernetes_role_binding_v1" "crb" {
  for_each = toset(var.cluster_roles)

  metadata {
    generate_name = "${kubernetes_service_account_v1.sa.metadata[0].name}-bind-"
    namespace     = var.namespace
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = each.key
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.sa.metadata[0].name
    namespace = var.namespace
  }
}
