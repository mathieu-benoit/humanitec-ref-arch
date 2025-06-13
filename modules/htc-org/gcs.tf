resource "humanitec_resource_definition" "gcs" {
  driver_type    = "humanitec/opentofu-container-runner"
  id             = "gcs"
  name           = "gcs"
  type           = "gcs"
  driver_account = "$${resources['config.default#app'].account}"
  driver_inputs = {
    values_string = jsonencode({
      "source" = {
        "ref"  = "refs/heads/main"
        "url"  = "https://github.com/mathieu-benoit/terraform-modules-samples.git"
        "path" = "gcp-gcs"
      }
      "variables" = {
        "app_id"     = "$${context.app.id}"
        "env_id"     = "$${context.env.id}"
        "res_id"     = "$${context.res.id}"
        "project_id" = "$${resources['config.default#app'].outputs.gcp_project_id}"
        "region"     = "$${resources['config.default#app'].outputs.gcp_region}"
      }
      "use_default_backend" = true
      "credentials_config" = {
        "variables" = {
          "access_token" = "access_token"
        }
      }
    })
  }
  provision = {
    "gcp-iam-policy-binding.gcs-default" = {
      is_dependent     = true
      match_dependents = false
    }
  }
}

resource "humanitec_resource_definition_criteria" "gcs" {
  resource_definition_id = resource.humanitec_resource_definition.gcs.id
}