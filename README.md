[![CI](https://github.com/mathieu-benoit/humanitec-ref-arch/actions/workflows/ci.yaml/badge.svg)](https://github.com/mathieu-benoit/humanitec-ref-arch/actions/workflows/ci.yaml)

![](./humanitec-ref-arch.png)

Terraform Blueprint to deploy the Humanitec resources based on 5 different Terraform Modules:
- Google Cloud
  - [GKE(s) Terraform Module](./modules/gcp-cluster/README.md)
  - [App(s) Terraform Module](./modules/gcp-app/README.md)
- Humanitec
  - [Org level Terraform Module](./modules/htc-org/README.md)
  - [Cluster(s) level Terraform Module](./modules/htc-cluster/README.md)
  - [App(s) level Terraform Module](./modules/htc-app/README.md)

TOC:
- [Assumptions](#assumptions)
- [Deploy the Terraform Blueprint](#deploy-the-terraform-blueprint)
- [Test connectivity](#test-connectivity)
- [Update Developers's CD pipelines](#update-developerss-cd-pipelines)
- [Terraform Blueprint documentation](#terraform-blueprint-documentation)
- [Available resource types for the Developers in their Score files](#available-resource-types-for-the-developers-in-their-score-files)

# Assumptions

- GKE cluster provisioned in GCP as an input for the `cluster` Terraform Module.
- "Project" == "Humanitec App"
- 1 GKE cluster per Env Type
- 1 Humanitec Service User/Token per {App, Env Type}
- People as:
  - `Member` at the Org level
  - `Viewer` at the App Level
- Service User:
  - `Artefact Contributor` for Development and `Member` for other Environments at the Org level
  - `Developer` at the App Level
  - `Deployer` at the Env Type

# Deploy the Terraform Blueprint

```bash
export HUMANITEC_ORG=FIXME
export HUMANITEC_TOKEN=FIXME

terraform workspace select -or-create=true ${HUMANITEC_ORG}

terraform init -upgrade

terraform plan \
    -var org_id=${HUMANITEC_ORG} \
    -var token=${HUMANITEC_TOKEN} \
    -var 'clusters=[{name="mabenoit-demo", region="northamerica-northeast1", project_id="mabenoit-demo-458522"}]' \
    -var humanitec_crds_already_installed=true \
    -out out.tfplan

terraform apply out.tfplan
```

# Disable not used default resource definitions

Here are the default (Humanitec managed) resource definition not used anymore that we can explicitly disable now:
```bash
humctl api PUT /orgs/${HUMANITEC_ORG}/resources/defs/default-humanitec-base-env/criteria --data '[]'
humctl api PUT /orgs/${HUMANITEC_ORG}/resources/defs/default-humanitec-namespace/criteria --data '[]'
humctl api PUT /orgs/${HUMANITEC_ORG}/resources/defs/default-humanitec-workload-res/criteria --data '[]'
humctl api PUT /orgs/${HUMANITEC_ORG}/resources/defs/default-humanitec-dns/criteria --data '[]'
humctl api PUT /orgs/${HUMANITEC_ORG}/resources/defs/default-humanitec-ingress/criteria --data '[]'
humctl api PUT /orgs/${HUMANITEC_ORG}/resources/defs/default-humanitec-tls-cert/criteria --data '[]'
```

# Test connectivity

```bash
humctl get resource-account

ACCOUNT_ID=FIXME

humctl resources check-account ${ACCOUNT_ID}

APP_ID=sail-sharp
ENV_ID=development
ENV_TYPE=development

humctl resources check-connectivity \
    --app ${APP_ID} \
    --env ${ENV_ID} \
    --env-type ${ENV_TYPE}
```

# Update Developers's CD pipelines

Update Developer's CD pipelines based on `outputs`:
```bash
terraform output service_users_tokens
```

You can also use this token locally (`HUMANITEC_TOKEN`) and run `humctl score deploy --app --env`

# Tech Radar

![](./tech-radar.png)

To get the available resource types for the Developers in their Score files

```bash
humctl score available-resource-types
```

```none
Name                                    Type                    Category        Class
Environment                             environment             score           default
Service                                 service                 score           default
Google Cloud Pub/Sub Subscription       gcp-pubsub-subscription messaging       default
Persistent Volume                       volume                  datastore       default
Redis                                   redis                   datastore       default
DNS                                     dns                     dns             default
Route                                   route                   ingress         default
Google Cloud Storage Bucket             gcs                     datastore       default
TLS certificate                         tls-cert                security        default
Google Cloud Pub/Sub Topic              gcp-pubsub-topic        messaging       default
Postgres                                postgres                datastore       default
Google Cloud Vertex AI                  gcp-vertex-ai                           default
```

# Main Terraform Blueprint documentation

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
| token | Token to provision objects in Humanitec Organization | `string` | n/a | yes |
| env\_types | n/a | <pre>list(object({<br/>    id          = string<br/>    description = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "description": "Development",<br/>    "id": "development"<br/>  },<br/>  {<br/>    "description": "Staging",<br/>    "id": "staging"<br/>  },<br/>  {<br/>    "description": "Production",<br/>    "id": "production"<br/>  }<br/>]</pre> | no |
| humanitec\_crds\_already\_installed | Custom resource definitions must be applied before custom resources. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| service\_users\_tokens | n/a |
<!-- END_TF_DOCS -->
