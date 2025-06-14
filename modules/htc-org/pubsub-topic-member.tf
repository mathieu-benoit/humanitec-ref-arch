resource "humanitec_resource_definition" "pubsub_topic_member" {
  driver_type    = "humanitec/opentofu-container-runner"
  id             = "pubsub-topic-member"
  name           = "pubsub-topic-member"
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
        "path" = "gcp-pubsub-topic-iam"
      }
      "variables" = {
        "app_id"     = "$${context.app.id}"
        "env_id"     = "$${context.env.id}"
        "res_id"     = "$${context.res.id}"
        "project_id" = "$${resources['config.default#app'].outputs.gcp_project_id}"
        "topic_name" = "$${resources['gcp-pubsub-topic.default'].outputs.name}"
      }
      "files" = {
        "input_vars.auto.tfvars.json" = "{\"principals\": $${resources['gcp-pubsub-topic.default<workload>k8s-service-account'].outputs.principal}}"
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

resource "humanitec_resource_definition_criteria" "pubsub_topic_member" {
  resource_definition_id = resource.humanitec_resource_definition.pubsub_topic_member.id
  class                  = "pubsub-topic-default"
}