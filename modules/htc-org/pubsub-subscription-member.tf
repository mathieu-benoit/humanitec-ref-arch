resource "humanitec_resource_definition" "pubsub_subscription_member" {
  driver_type    = "humanitec/opentofu-container-runner"
  id             = "pubsub-subscription-member"
  name           = "pubsub-subscription-member"
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
        "path" = "gcp-pubsub-subscription-iam"
      }
      "variables" = {
        "app_id"            = "$${context.app.id}"
        "env_id"            = "$${context.env.id}"
        "res_id"            = "$${context.res.id}"
        "project_id"        = "$${resources['config.default#app'].outputs.gcp_project_id}"
        "subscription_name" = "$${resources['gcp-pubsub-subscription.default'].outputs.name}"
      }
      "files" = {
        "input_vars.auto.tfvars.json" = "{\"principals\": $${resources['gcp-pubsub-subscription.default<workload>k8s-service-account'].outputs.principal}}"
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

resource "humanitec_resource_definition_criteria" "pubsub_subscription_member" {
  resource_definition_id = resource.humanitec_resource_definition.pubsub_subscription_member.id
  class                  = "pubsub-subscription-default"
}