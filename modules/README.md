<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| google | ~> 5.1 |
| humanitec | ~> 1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| apps | ./modules/htc-app | n/a |
| gcp\_app | ./modules/gcp-app | n/a |
| gcp\_cluster | ./modules/gcp-cluster | n/a |
| htc\_cluster | ./modules/htc-cluster | n/a |
| org | ./modules/htc-org | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| apps | n/a | <pre>list(object({<br/>    id             = string<br/>    name           = string<br/>    cost_center    = string<br/>    gcp_project_id = string<br/>    viewer_users = list(object({<br/>      email = string<br/>    }))<br/>    resource_quota = object({<br/>      limits-cpu    = string<br/>      limits-memory = string<br/>    })<br/>  }))</pre> | n/a | yes |
| clusters | n/a | <pre>list(object({<br/>    project_id = string<br/>    name       = string<br/>    region     = string<br/>  }))</pre> | n/a | yes |
| org\_id | ID of the Humanitec Organization | `string` | n/a | yes |
| token | Token to authenticate to Humanitec (just use for terracurl\_request for custom resource types) | `string` | n/a | yes |
| env\_types | n/a | <pre>list(object({<br/>    id          = string<br/>    description = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "description": "Development",<br/>    "id": "development"<br/>  },<br/>  {<br/>    "description": "Staging",<br/>    "id": "staging"<br/>  },<br/>  {<br/>    "description": "Production",<br/>    "id": "production"<br/>  }<br/>]</pre> | no |
| humanitec\_crds\_already\_installed | Custom resource definitions must be applied before custom resources. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| service\_users\_tokens | n/a |
<!-- END_TF_DOCS -->