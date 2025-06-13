resource "humanitec_resource_definition" "gcs_member" {
  driver_type    = "humanitec/opentofu-container-runner"
  id             = "gcs-member"
  name           = "gcs-member"
  type           = "gcp-iam-policy-binding"
  driver_account = "$${resources['config.default#app'].account}"
  driver_inputs = {
    values_string = jsonencode({
      "runner" = {
        "image" = local.opentofu_container_image
      }
      "source" = {
        "ref"  = "refs/heads/main"
        "url"  = "https://github.com/mathieu-benoit/terraform-modules-samples.git"
        "path" = "gcp-gcs-iam"
      }
      "variables" = {
        "app_id"          = "$${context.app.id}"
        "env_id"          = "$${context.env.id}"
        "res_id"          = "$${context.res.id}"
        "gcs_bucket_name" = "$${resources['gcs.default'].outputs.name}"
      }
      "files" = {
        "input_vars.auto.tfvars.json" = "{\"principals\": $${resources['gcs.default<workload>k8s-service-account'].outputs.principal}}"
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

resource "humanitec_resource_definition_criteria" "gcs_member" {
  resource_definition_id = resource.humanitec_resource_definition.gcs_member.id
  class                  = "gcs-default"
}