# Humanitec Cluster level Terraform Module

<!-- BEGIN_TF_DOCS -->


## Providers

| Name | Version |
|------|---------|
| humanitec | n/a |

## Resources

| Name | Type |
|------|------|
| [humanitec_agent.agent](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/agent) | resource |
| [humanitec_key.operator](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/key) | resource |
| [humanitec_resource_account.cluster_account](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_account) | resource |
| [humanitec_resource_definition.agent](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition) | resource |
| [humanitec_resource_definition.cluster_config](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition) | resource |
| [humanitec_resource_definition.k8s_cluster](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition) | resource |
| [humanitec_resource_definition.opentofu_runner_config](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition) | resource |
| [humanitec_resource_definition_criteria.agent](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [humanitec_resource_definition_criteria.cluster_config](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [humanitec_resource_definition_criteria.k8s_cluster](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [humanitec_resource_definition_criteria.opentofu_runner_config](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| agent\_public\_key | The public key of the Agent. | `string` | n/a | yes |
| cluster\_access\_gsa\_email | The email of the GSA to access the GKE cluster from Humanitec. | `string` | n/a | yes |
| env\_types | n/a | <pre>list(object({<br/>    id          = string<br/>    description = string<br/>  }))</pre> | n/a | yes |
| external\_gateway\_name | The Gateway API name assigned to this GKE cluster for external traffic. | `string` | n/a | yes |
| external\_security\_policy\_name | The Cloud Armor Security Policy name assigned to this GKE cluster for external traffic. | `string` | n/a | yes |
| gcp\_wi\_pool\_provider\_name | The Workload Identity Pool Provider name to access the GKE cluster from Humanitec. | `string` | n/a | yes |
| id | ID of the GKE cluster resource | `string` | n/a | yes |
| load\_balancer | The Load Balancer of the EKS cluster | `string` | n/a | yes |
| name | GKE cluster name | `string` | n/a | yes |
| operator\_public\_key | The public key of the Operator. | `string` | n/a | yes |
| org\_id | ID of the Humanitec Organization | `string` | n/a | yes |
| project\_id | GCP Project ID | `string` | n/a | yes |
| project\_number | GCP Project number | `string` | n/a | yes |
| region | GCP Region | `string` | n/a | yes |
<!-- END_TF_DOCS -->