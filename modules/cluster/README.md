# Cluster level Terraform Module

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| humanitec | ~> 1.0 |
| tls | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| humanitec | ~> 1.0 |
| tls | ~> 4.0 |

## Resources

| Name | Type |
|------|------|
| [humanitec_agent.agent](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/agent) | resource |
| [humanitec_key.operator](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/key) | resource |
| [humanitec_resource_account.cloud_account](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_account) | resource |
| [humanitec_resource_definition.agent](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition) | resource |
| [humanitec_resource_definition.cluster_config](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition) | resource |
| [humanitec_resource_definition.eks](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition) | resource |
| [tls_private_key.agent](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.operator](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | The AWS region | `string` | n/a | yes |
| cloud\_account | The AWS Account associated to the EKS cluster and provisioning any infrastructure via Terraform too | <pre>object({<br/>    aws_role    = string<br/>    external_id = string<br/>  })</pre> | n/a | yes |
| env\_type\_id | The Env Type ID for the EKS cluster | `string` | n/a | yes |
| load\_balancer | The Load Balancer of the EKS cluster | `string` | n/a | yes |
| load\_balancer\_hosted\_zone | The Load Balancer Hosted Zone of the EKS cluster | `string` | n/a | yes |
| name | The Name of the EKS cluster | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| agent\_private\_key | n/a |
| cloud\_account\_id | n/a |
| operator\_private\_key | n/a |
<!-- END_TF_DOCS -->