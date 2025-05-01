Terraform Blueprint to deploy the Humanitec resources based on 4 different Terraform Modules:
- [Org level Terraform Module](../modules/org/README.md)
- [Cluster(s) level Terraform Module](../modules/cluster/README.md)
- [App(s) level Terraform Module](../modules/app/README.md)

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

- EKS cluster provisioned in AWS as an input for the `cluster` Terraform Module.
- AWS Account info as an input for the `cluster` Terraform Module.

## Assumptions

- "Project" == "Humanitec's App"
- Env Types: `non-prod` and `prod`
- 1 AWS Account per {Value Chain, Env Type}
- 1 EKS cluster per {Value Chain, Env Type}
- The Cloud Account accessing the EKS cluster is also provisioning AWS resources like DNS, databases, S3, etc.
- Only `internal` DNS is supported as `default` for now
- TODO: Hosted Zone for `internal` DNS is coming from the EKS's one + Region too.
- 1 Humanitec Service User/Token per {App, Env Type}
- People as:
  - `Member` at the Org level
  - `Viewer` at the App Level
- Service User:
  - `Member` at the Org level
  - `Developer` at the App Level
  - `Deployer` at the Env Type

## TODOs

- Bill: Double check and test the DNS internal setup (for examples: check SecretStore for accessing git repo, check record_name naming convention, etc.)
- Marian: AWS Account and EKS info to pass as inputs of the Blueprint
- Marian: Operator/Agent to install in EKS clusters with generated info by the Blueprint
- Bill: `ScoreDeployConfig`
- Bill: GitLab Pipeline template
- Mathieu: Advise for Prod/DR envs strategy (Pipelines)
  - Preventing manual deployment in DR
  - Auto-deploy in DR from Prod

Later:
- Self-hosted Terraform Runner
- EFS Volume
- Ephemeral Environment

## Deploy the Terraform Blueprint

```bash
HUMANITEC_ORG=FIXME

humctl login

cd terraform/getting-started
terraform workspace select -or-create=true ${HUMANITEC_ORG}

terraform init -upgrade

# Edit the terraform.tfvars accordingly to add/update your value chains and apps.

terraform plan \
    -var org_id=${HUMANITEC_ORG} \
    -out out.tfplan

terraform apply out.tfplan
```

## Update EKS cluster

Update EKS cluster based on `outputs`:
```bash
terraform output operator_private_keys

terraform output agent_private_keys
```

```bash
AGENT_PRIVATE_KEY=FIXME
OPERATOR_PRIVATE_KEY=FIXME

helm install humanitec-agent \
    oci://ghcr.io/humanitec/charts/humanitec-agent \
    --namespace humanitec-agent \
    --create-namespace \
    --set "humanitec.org=${HUMANITEC_ORG}" \
    --set "humanitec.privateKey=${AGENT_PRIVATE_KEY}"

helm install humanitec-operator \
    oci://ghcr.io/humanitec/charts/humanitec-operator \
    --namespace humanitec-operator \
    --create-namespace
kubectl --namespace humanitec-operator create secret generic humanitec-operator-private-key \
    --from-literal=privateKey=${OPERATOR_PRIVATE_KEY} \
    --from-literal=humanitecOrganisationID=${HUMANITEC_ORG}
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
| humanitec | ~> 1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| apps | ./modules/app | n/a |
| clusters | ./modules/cluster | n/a |
| org | ./modules/org | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| apps | n/a | <pre>list(object({<br/>    id   = string<br/>    name = string<br/>    viewer_users = list(object({<br/>      email = string<br/>    }))<br/>  }))</pre> | n/a | yes |
| clusters | n/a | <pre>list(object({<br/>    env_type_id               = string<br/>    name                      = string<br/>    load_balancer             = string<br/>    load_balancer_hosted_zone = string<br/>    aws_region                = string<br/>    cloud_account = object({<br/>      aws_role    = string<br/>      external_id = string<br/>    })<br/>  }))</pre> | n/a | yes |
| org\_id | ID of the Humanitec Organization | `string` | n/a | yes |
| env\_types | n/a | <pre>list(object({<br/>    id          = string<br/>    description = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "description": "Environments used for Non-Production.",<br/>    "id": "non-prod"<br/>  },<br/>  {<br/>    "description": "Environments used for Production.",<br/>    "id": "prod"<br/>  }<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| agent\_private\_keys | n/a |
| cloud\_accounts\_ids | n/a |
| operator\_private\_keys | n/a |
| service\_users\_tokens | n/a |
<!-- END_TF_DOCS -->
