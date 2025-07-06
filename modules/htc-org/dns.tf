resource "humanitec_resource_definition" "dns" {
  driver_type    = "humanitec/opentofu-container-runner"
  id             = "dns"
  name           = "dns"
  type           = "${var.org_id}/dns"
  driver_account = "$${resources['config.default#app'].account}"
  driver_inputs = {
    values_string = jsonencode({
      "runner" = {
        "image" = local.opentofu_container_image
      }
      "source" = {
        "ref"  = "refs/heads/main"
        "url"  = "https://github.com/mathieu-benoit/terraform-modules-samples.git"
        "path" = "gcp-cloud-endpoint"
      }
      "variables" = {
        "app_id"     = "$${context.app.id}"
        "env_id"     = "$${context.env.id}"
        "res_id"     = "$${context.res.id}"
        "project_id" = "$${resources['config.default#app'].outputs.gcp_project_id}"
        "ip_address" = "$${resources['config.default#gke'].outputs.load_balancer}"
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
    "ingress" = {
      is_dependent     = false
      match_dependents = false
    }
  }
}

resource "humanitec_resource_definition_criteria" "dns" {
  resource_definition_id = resource.humanitec_resource_definition.dns.id
  force_delete           = true
}