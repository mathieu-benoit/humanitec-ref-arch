# Google Cloud App level Terraform Module

<!-- BEGIN_TF_DOCS -->


## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Resources

| Name | Type |
|------|------|
| [google_project_iam_member.gcs](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.iammember](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.gsm](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.memorystore](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.terraform_provisioner](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.wi](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_id | ID of the Humanitec Application | `string` | n/a | yes |
| gcp\_project\_id | Google Cloud Project ID | `string` | n/a | yes |
| gcp\_wi\_pool\_name | The Workload Identity Pool name to access the GCP Project from Humanitec. | `string` | n/a | yes |
| org\_id | ID of the Humanitec Organization | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cloud\_account\_gsa\_email | n/a |
| cloud\_account\_id | n/a |
<!-- END_TF_DOCS -->