resource "humanitec_resource_definition" "cluster_config" {
  driver_type = "humanitec/echo"
  id          = "${var.id}-config"
  name        = "${var.id}-config"
  type        = "config"
  driver_inputs = {
    values_string = jsonencode({
      "region"         = var.region
      "project_id"     = var.project_id
      "project_number" = var.project_number
    })
  }
}

resource "humanitec_resource_definition_criteria" "cluster_config" {
  for_each = { for env_type in var.env_types : env_type.id => env_type }

  resource_definition_id = humanitec_resource_definition.cluster_config.id
  env_type               = each.value.id

  force_delete = true
}