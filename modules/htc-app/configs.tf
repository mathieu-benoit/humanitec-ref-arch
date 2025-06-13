locals {
  app_res_id   = "app"
  quota_res_id = "quota"
}

resource "humanitec_resource_definition" "app_config" {
  driver_type    = "humanitec/echo"
  id             = "${var.app_id}-config"
  name           = "${var.app_id}-config"
  type           = "config"
  driver_account = var.cloud_account_id
  driver_inputs = {
    values_string = jsonencode({
      "app_name"       = var.app_name
      "cost_center"    = var.cost_center
      "gcp_project_id" = var.gcp_project_id
      "gcp_region"     = var.gcp_region
    })
  }
}

resource "humanitec_resource_definition_criteria" "app_config" {
  resource_definition_id = humanitec_resource_definition.app_config.id
  force_delete           = true
  app_id                 = var.app_id
  res_id                 = local.app_res_id
}

resource "humanitec_resource_definition" "quota_config" {
  count = var.resource_quota == null ? 0 : 1

  driver_type = "humanitec/echo"
  id          = "${var.app_id}-quota-config"
  name        = "${var.app_id}-quota-config"
  type        = "config"
  driver_inputs = {
    values_string = jsonencode({
      "limits-cpu"    = var.resource_quota.limits-cpu
      "limits-memory" = var.resource_quota.limits-memory
    })
  }
}

resource "humanitec_resource_definition_criteria" "quota_config" {
  count = var.resource_quota == null ? 0 : 1

  resource_definition_id = humanitec_resource_definition.quota_config[count.index].id
  force_delete           = true
  app_id                 = var.app_id
  res_id                 = local.quota_res_id
}