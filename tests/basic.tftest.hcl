mock_provider "kubernetes" {}

run "sa_with_name" {
  command = plan

  variables {
    additional_annotations = {
      name = "example-annotation"
    }
    additional_labels = {
      mylabel = "label-value"
    }
    namespace = "default"
    name = "fizzybuzzy"
    automount_service_account_token = false
    
    roles = ["admin"]
    cluster_roles = ["cluster-admin"]
  }

  assert {
    condition     = kubernetes_service_account_v1.sa.metadata[0].name == "fizzybuzzy"
    error_message = "name should be set"
  }
  assert {
    condition     = kubernetes_service_account_v1.sa.metadata[0].generate_name == null
    error_message = "generate_name should not be set"
  }
  assert {
    condition     = kubernetes_service_account_v1.sa.automount_service_account_token == false
    error_message = "automount_service_account_token should be false"
  }
  assert {
    condition = jsonencode(kubernetes_service_account_v1.sa.metadata[0].annotations) == jsonencode({
      name = "example-annotation"
    })
    error_message = "annotations should be set"
  }
  assert {
    condition = jsonencode(kubernetes_service_account_v1.sa.metadata[0].labels) == jsonencode({
      mylabel = "label-value"
    })
    error_message = "labels should be set"
  }
}

run "sa_with_name_prefix" {
  command = plan

  variables {
    additional_annotations = {
      name = "example-annotation"
    }
    additional_labels = {
      mylabel = "label-value"
    }
    namespace = "default"
    name_prefix = "fizzybuzzy"
  }

  assert {
    condition     = kubernetes_service_account_v1.sa.metadata[0].generate_name == "fizzybuzzy"
    error_message = "generate_name should be set"
  }
  assert {
    condition     = kubernetes_service_account_v1.sa.automount_service_account_token == true
    error_message = "automount_service_account_token should be true"
  }
  assert {
    condition = jsonencode(kubernetes_service_account_v1.sa.metadata[0].annotations) == jsonencode({
      name = "example-annotation"
    })
    error_message = "annotations should be set"
  }
  assert {
    condition = jsonencode(kubernetes_service_account_v1.sa.metadata[0].labels) == jsonencode({
      mylabel = "label-value"
    })
    error_message = "labels should be set"
  }
}
