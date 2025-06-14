resource "humanitec_resource_definition" "vertex_ai_member" {
  driver_type    = "humanitec/opentofu-container-runner"
  id             = "vertex-ai-member"
  name           = "vertex-ai-member"
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
        "path" = "gcp-vertex-ai-iam"
      }
      "variables" = {
        "app_id"     = "$${context.app.id}"
        "env_id"     = "$${context.env.id}"
        "res_id"     = "$${context.res.id}"
        "project_id" = "$${resources['gcp-vertex-ai.default'].outputs.project}"
      }
      "files" = {
        "input_vars.auto.tfvars.json" = "{\"principals\": $${resources['gcp-vertex-ai.default<workload>k8s-service-account'].outputs.principal}}"
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

resource "humanitec_resource_definition_criteria" "vertex_ai_member" {
  resource_definition_id = resource.humanitec_resource_definition.vertex_ai_member.id
  class                  = "vertex-ai-default"
}