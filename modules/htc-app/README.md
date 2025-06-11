# App level Terraform Module

<!-- BEGIN_TF_DOCS -->


## Providers

| Name | Version |
|------|---------|
| humanitec | n/a |

## Resources

| Name | Type |
|------|------|
| [humanitec_application.app](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/application) | resource |
| [humanitec_application_user.service_user](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/application_user) | resource |
| [humanitec_application_user.viewer](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/application_user) | resource |
| [humanitec_environment.env](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/environment) | resource |
| [humanitec_environment_type_user.service_user](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/environment_type_user) | resource |
| [humanitec_pipeline.wait_for_readiness](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/pipeline) | resource |
| [humanitec_pipeline_criteria.wait_for_readiness](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/pipeline_criteria) | resource |
| [humanitec_resource_definition.app_config](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition) | resource |
| [humanitec_resource_definition.quota_config](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition) | resource |
| [humanitec_resource_definition_criteria.app_config](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [humanitec_resource_definition_criteria.quota_config](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/resource_definition_criteria) | resource |
| [humanitec_service_user_token.service_user](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/service_user_token) | resource |
| [humanitec_user.service_user](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/resources/user) | resource |
| [humanitec_users.member](https://registry.terraform.io/providers/humanitec/humanitec/latest/docs/data-sources/users) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_id | ID of the Humanitec Application | `string` | n/a | yes |
| app\_name | Name of the Humanitec Application | `string` | n/a | yes |
| cost\_center | Cost Center ID | `string` | n/a | yes |
| env\_types | n/a | <pre>list(object({<br/>    id          = string<br/>    description = string<br/>  }))</pre> | n/a | yes |
| gcp\_project\_id | Google Cloud Project ID | `string` | n/a | yes |
| envs | n/a | <pre>list(object({<br/>    id   = string<br/>    name = string<br/>    type = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "id": "development",<br/>    "name": "development",<br/>    "type": "development"<br/>  },<br/>  {<br/>    "id": "staging",<br/>    "name": "staging",<br/>    "type": "staging"<br/>  },<br/>  {<br/>    "id": "production",<br/>    "name": "production",<br/>    "type": "production"<br/>  }<br/>]</pre> | no |
| resource\_quota | n/a | <pre>object({<br/>    limits-cpu    = string<br/>    limits-memory = string<br/>  })</pre> | `null` | no |
| viewer\_users | n/a | <pre>list(object({<br/>    email = string<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| service\_users\_tokens | n/a |
<!-- END_TF_DOCS -->