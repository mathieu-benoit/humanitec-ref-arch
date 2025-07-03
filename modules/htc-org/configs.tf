locals {
  quota_res_id = "quota"
}

resource "humanitec_resource_definition" "quota_config" {
  driver_type = "humanitec/echo"
  id          = "default-quota-config"
  name        = "default-quota-config"
  type        = "config"
  driver_inputs = {
    values_string = jsonencode({
      "limits-cpu"    = "256m"
      "limits-memory" = "256Mi"
    })
  }
}

resource "humanitec_resource_definition_criteria" "quota_config" {
  resource_definition_id = humanitec_resource_definition.quota_config.id
  force_delete           = true
  res_id                 = local.quota_res_id
}