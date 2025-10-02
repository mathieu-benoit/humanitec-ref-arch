resource "humanitec_resource_definition" "apphub_workload" {
  driver_type    = "humanitec/opentofu-container-runner"
  id             = "apphub-workload"
  name           = "apphub-workload"
  type           = humanitec_resource_type.apphub_workload.id
  driver_account = "$${resources['config.default#app'].account}"
  driver_inputs = {
    values_string = jsonencode({
      "runner" = {
        "image" = local.opentofu_container_image
      }
      "source" = {
        "ref"  = "refs/heads/main"
        "url"  = "https://github.com/mathieu-benoit/terraform-modules-samples.git"
        "path" = "gcp-app-hub-workload"
      }
      "variables" = {
        "app_id"             = "$${context.app.id}"
        "env_id"             = "$${context.env.id}"
        "env_type"           = "$${context.env.type}"
        "res_id"             = "$${context.res.id}"
        "project_id"         = "$${resources['config.default#app'].outputs.gcp_project_id}"
        "region"             = "$${resources['config.default#app'].outputs.gcp_region}"
        "gke_project_number" = "$${resources['config.default#gke'].outputs.project_number}"
        "gke_name"           = "$${resources['config.default#gke'].outputs.name}"
        "namespace"          = "$${resources['k8s-namespace.default#k8s-namespace'].outputs.namespace}"
      }
      "use_default_backend" = true
      "credentials_config" = {
        "variables" = {
          "access_token" = "access_token"
        }
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "apphub_workload" {
  resource_definition_id = resource.humanitec_resource_definition.apphub_workload.id
}