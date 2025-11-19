# k8s-service-account-kubernetes

This is a Terraform / OpenTofu compatible module to be used to provision `k8s-service-account` resources on top of Kubernetes for the Humanitec Orchestrator.

This can optionally provision role and cluster-role bindings for the service account without depending on other modules. These are always scoped to the namespace. You will need to use a separate module if you wish to bind cluster role bindings at a cluster level.

## Requirements

1. There must be a module provider setup for `kubernetes` (`hashicorp/kubernetes`).
2. There must be a resource type setup for `k8s-service-account`, for example:

    ```shell
    hctl create resource-type k8s-service-account --set=description='Kubernetes Service Account' --set=output_schema='{"type":"object","required":["name"],"properties":{"name":{"type":"string"}}}'
    ```

## Installation

Install this with the `hctl` CLI, you should replace the `CHANGEME` in the module source with the latest release tag, replace the `CHANGEME` in the provider mapping with your real provider type and alias for Kubernetes.

```shell
hctl create module \
    --set=resource_type=k8s-service-account \
    --set=module_source=git::https://github.com/humanitec-tf-modules/k8s-service-account-kubernetes?ref=CHANGEME \
    --set=provider_mapping='{"kubernetes": "CHANGEME"}' \
    --set=dependencies='{"ns":{"type":"k8s-namespace","id":"env-namespace"}}' \
    --set=module_inputs='{"namespace": "${resources.ns.outputs.name}"}'
```

The `namespace` is a required input. You can set it to a constant or configure a module dependency to pull it from elsewhere in the graph as in the example above.

You can also use any of the input parameters described further down this document to modify the behavior.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.38.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_role_binding_v1.crb](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding_v1) | resource |
| [kubernetes_role_binding_v1.rb](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding_v1) | resource |
| [kubernetes_service_account_v1.sa](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account_v1) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_annotations"></a> [additional\_annotations](#input\_additional\_annotations) | Additional annotations to add to the service account. | `map(string)` | `{}` | no |
| <a name="input_additional_labels"></a> [additional\_labels](#input\_additional\_labels) | Additional labels to add to the service account. | `map(string)` | `{}` | no |
| <a name="input_automount_service_account_token"></a> [automount\_service\_account\_token](#input\_automount\_service\_account\_token) | Enable automatic mounting of the service account token | `bool` | `true` | no |
| <a name="input_cluster_roles"></a> [cluster\_roles](#input\_cluster\_roles) | Cluster roles to bind to the service account and scoped to the namespace | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | The explicit name of the service account to create. | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | The name prefix to use for generate\_name. | `string` | `"sa-"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to create the service account in. | `string` | n/a | yes |
| <a name="input_roles"></a> [roles](#input\_roles) | Roles to bind to the service account | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_humanitec_metadata"></a> [humanitec\_metadata](#output\_humanitec\_metadata) | Metadata for Humanitec. |
| <a name="output_name"></a> [name](#output\_name) | The name of the service account |
<!-- END_TF_DOCS -->