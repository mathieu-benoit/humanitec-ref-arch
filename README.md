TODOs:
- Arch diagram
- HTC
  - memorystore with OT
  - gcs with WI
  - Backstage
  - apphub
- GCP
  - Cloud Account for GKE
  - TF runner

Terraform Blueprint to deploy the Humanitec resources based on 4 different Terraform Modules:
- Google Cloud
  - [GKE Terraform Module](../modules/gcp-cluster/README.md)
- Humanitec
  - [Org level Terraform Module](../modules/htc-org/README.md)
  - [Cluster(s) level Terraform Module](../modules/htc-cluster/README.md)
  - [App(s) level Terraform Module](../modules/htc-app/README.md)

TOC:
- [Prerequisites](#prerequisites)
- [Assumptions](#assumptions)
- [TODOs](#todos)
- [Deploy the Terraform Blueprint](#deploy-the-terraform-blueprint)
- [Update EKS cluster](#update-eks-cluster)
- [Test connectivity](#test-connectivity)
- [Update Developers's CD pipelines](#update-developerss-cd-pipelines)
- [(Optional) Destroy the Terraform Blueprint](#destroy-the-terraform-blueprint)
- [Terraform Blueprint documentation](#terraform-blueprint-documentation)

## Prerequisites

- GKE cluster provisioned in GCP as an input for the `cluster` Terraform Module.

## Assumptions

- "Project" == "Humanitec App"
- 1 GKE cluster per Env Type
- 1 Humanitec Service User/Token per {App, Env Type}
- People as:
  - `Member` at the Org level
  - `Viewer` at the App Level
- Service User:
  - `Member` at the Org level
  - `Developer` at the App Level
  - `Deployer` at the Env Type

## Deploy the Terraform Blueprint

```bash
HUMANITEC_ORG=FIXME

humctl login

terraform workspace select -or-create=true ${HUMANITEC_ORG}

terraform init -upgrade

terraform plan \
    -var org_id=${HUMANITEC_ORG} \
    -var 'clusters=[{name="mabenoit-demo", region="northamerica-northeast1", project_id="mabenoit-demo-458522"}]' \
    -var humanitec_crds_already_installed=true \
    -out out.tfplan

terraform apply out.tfplan
```

## Test connectivity

```bash
terraform output cloud_accounts_ids

ACCOUNT_ID=FIXME

humctl resources check-account ${ACCOUNT_ID}

APP_ID=FIXME
ENV_ID=FIXME
ENV_TYPE=FIXME

humctl resources check-connectivity \
    --app ${APP_ID} \
    --env ${ENV_ID} \
    --env-type ${ENV_TYPE}
```

## Update Developers's CD pipelines

Update Developer's CD pipelines based on `outputs`:
```bash
terraform output service_users_tokens
```

You can also use this token locally (`HUMANITEC_TOKEN`) and run `humctl score deploy --app --env`

## Destroy the Terraform Blueprint
```bash
terraform destroy \
    -var org_id=${HUMANITEC_ORG}
```

## Terraform Blueprint documentation

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
| gcp\_cluster | ./modules/gcp-cluster | n/a |
| htc\_clusters | ./modules/htc-cluster | n/a |
| org | ./modules/htc-org | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| apps | n/a | <pre>list(object({<br/>    id   = string<br/>    name = string<br/>    viewer_users = list(object({<br/>      email = string<br/>    }))<br/>  }))</pre> | n/a | yes |
| clusters | n/a | <pre>list(object({<br/>    project_id = string<br/>    name       = string<br/>    region     = string<br/>  }))</pre> | n/a | yes |
| org\_id | ID of the Humanitec Organization | `string` | n/a | yes |
| env\_types | n/a | <pre>list(object({<br/>    id          = string<br/>    description = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "description": "Development",<br/>    "id": "development"<br/>  },<br/>  {<br/>    "description": "Staging",<br/>    "id": "staging"<br/>  },<br/>  {<br/>    "description": "Production",<br/>    "id": "production"<br/>  }<br/>]</pre> | no |
| humanitec\_crds\_already\_installed | Custom resource definitions must be applied before custom resources. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| service\_users\_tokens | n/a |
<!-- END_TF_DOCS -->
