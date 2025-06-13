resource "humanitec_resource_definition" "opentofu_runner_config" {
  driver_type = "humanitec/template"
  id          = "config-terraform-container-runner"
  name        = "Config For Terraform Container Runner Driver"
  type        = "config"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "outputs" = {
          "cluster" = {
            "account" = "${var.org_id}/${humanitec_resource_account.cluster_account.id}"
            "cluster" = {
              "cluster_type" = "gke"
              "zone"         = var.region
              "name"         = var.name
              "project_id"   = var.project_id
            }
          }
          "skip_permission_checks" = false
        }
        "secrets" = {
          "agent_url" = "{{ .driver.secrets.agent_url }}"
        }
      }
    })
    secrets_string = jsonencode({
      "agent_url" = "$${resources.agent#agent.outputs.url}"
    })
  }
}

resource "humanitec_resource_definition_criteria" "opentofu_runner_config" {
  for_each = { for env_type in var.env_types : env_type.id => env_type }

  resource_definition_id = resource.humanitec_resource_definition.opentofu_runner_config.id
  env_type               = each.value.id
  res_id                 = "opentofu-container-runner"

  force_delete = true
}