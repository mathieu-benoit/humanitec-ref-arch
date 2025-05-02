resource "humanitec_resource_definition" "cluster_config" {
  driver_type = "humanitec/echo"
  id          = "${var.id}-config"
  name        = "${var.id}-config"
  type        = "config"
  driver_inputs = {
    values_string = jsonencode({
      "region" = var.region
    })
  }
}

resource "humanitec_resource_definition_criteria" "cluster_config" {
  resource_definition_id = humanitec_resource_definition.cluster_config.id
  env_type               = var.env_type

  force_delete = true
}