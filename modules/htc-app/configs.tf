locals {
  app_res_id = "app"
}

resource "humanitec_resource_definition" "app_config" {
  driver_type = "humanitec/echo"
  id          = "${var.app_id}-config"
  name        = "${var.app_id}-config"
  type        = "config"
  driver_inputs = {
    values_string = jsonencode({
      "app_name" = var.app_name
    })
  }
}

resource "humanitec_resource_definition_criteria" "app_config" {
  resource_definition_id = humanitec_resource_definition.app_config.id
  force_delete           = true
  app_id                 = var.app_id
  res_id                 = local.app_res_id
}