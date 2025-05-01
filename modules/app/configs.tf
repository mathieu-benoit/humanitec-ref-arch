locals {
  agent_res_id       = "agent"
  app_res_id         = "app"
  cluster_res_id     = "cluster"
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

// Assuming that the "${each.value.cluster_name}-config" res def is already created by the cluster module.
resource "humanitec_resource_definition_criteria" "cluster_config" {
  for_each = { for cluster in var.clusters : cluster.cluster_name => cluster }

  resource_definition_id = "${each.value.cluster_name}-config"
  force_delete           = true
  app_id                 = var.app_id
  env_type               = each.value.env_type_id
  res_id                 = local.cluster_res_id
}