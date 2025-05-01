resource "humanitec_resource_definition" "dns_internal" {
  driver_type = "humanitec/terraform"
  id          = "dns-internal"
  name        = "dns-internal"
  type        = "dns"

  driver_account = "$${resources['config#cluster'].account}"
  driver_inputs = {
    secret_refs = jsonencode({
      source = {
        password = {
          ref   = "humanitec-read-only-gitlab"
          store = "eks-nonprod-store-default"
        }
      }
    })

    values_string = jsonencode({
      source = {
        path = "humanitec-resource-defs/dns/basic"
        rev  = "refs/heads/main"
        url  = "git::https://gitlab.ihsmarkit.com/mobility-platform-engineering/humanitec/resource-packs-aws.git"
      }

      append_logs_to_error = true

      credentials_config = {
        environment = {
          AWS_ACCESS_KEY_ID     = "AccessKeyId"
          AWS_SECRET_ACCESS_KEY = "SecretAccessKey"
          AWS_SESSION_TOKEN     = "SessionToken"
        }
      }

      variables = {
        region         = "$${resources['config#cluster'].outputs.aws_region}"
        res_id         = "$${context.res.id}"
        app_id         = "$${context.app.id}"
        env_id         = "$${context.env.id}"
        hosted_zone_id = "$${resources['config#cluster'].outputs.dns_internal_hosted_zone_id}"
        record_name    = "{{ index (splitList \".\" \"$${context.res.id}\") 1 }}-$${context.env.id}-$${context.app.id}"
      }
    })
  }
  provision = {
    "ingress" = {
      is_dependent = false
    }
  }
}

resource "humanitec_resource_definition_criteria" "dns_default" {
  resource_definition_id = humanitec_resource_definition.dns_internal.id
  class                  = "default"
  force_delete           = true
}

resource "humanitec_resource_definition_criteria" "dns_internal" {
  resource_definition_id = humanitec_resource_definition.dns_internal.id
  class                  = humanitec_resource_class.internal_dns.id
  force_delete           = true
}