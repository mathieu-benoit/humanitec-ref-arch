resource "humanitec_resource_definition" "memorystore_redis" {
  driver_type    = "humanitec/opentofu-container-runner"
  id             = "redis-memorystore"
  name           = "redis-memorystore"
  type           = "redis"
  driver_account = "$${resources['config.default#app'].account}"
  driver_inputs = {
    values_string = jsonencode({
      "runner" = {
        "image" = local.opentofu_container_image
      }
      "source" = {
        "ref"  = "refs/heads/main"
        "url"  = "https://github.com/mathieu-benoit/terraform-modules-samples.git"
        "path" = "gcp-memorystore-redis"
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
}

resource "humanitec_resource_definition_criteria" "memorystore_redis" {
  resource_definition_id = resource.humanitec_resource_definition.memorystore_redis.id
  env_type               = "staging"
}