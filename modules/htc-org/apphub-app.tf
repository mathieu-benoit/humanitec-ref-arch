resource "humanitec_resource_definition" "apphub_app" {
  driver_type    = "humanitec/opentofu-container-runner"
  id             = "apphub-app"
  name           = "apphub-app"
  type           = "${var.org_id}/${local.apphub_app_resource_type}"
  driver_account = "$${resources['config.default#app'].account}"
  driver_inputs = {
    values_string = jsonencode({
      "runner" = {
        "image" = local.opentofu_container_image
      }
      "source" = {
        "ref"  = "refs/heads/main"
        "url"  = "https://github.com/mathieu-benoit/terraform-modules-samples.git"
        "path" = "gcp-app-hub-app"
      }
      "variables" = {
        "app_id"     = "$${context.app.id}"
        "env_id"     = "$${context.env.id}"
        "env_type"   = "$${context.env.type}"
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

  /*depends_on = [
    terracurl_request.apphub_app_resource_type
  ]*/
}

resource "humanitec_resource_definition_criteria" "apphub_app" {
  resource_definition_id = resource.humanitec_resource_definition.apphub_app.id
}