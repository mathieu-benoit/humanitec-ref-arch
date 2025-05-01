// Assuming that the "${each.value.cluster_name}-agent" res def is already created by the cluster module.
resource "humanitec_resource_definition_criteria" "agent" {
  for_each = { for cluster in var.clusters : cluster.cluster_name => cluster }

  resource_definition_id = "${each.value.cluster_name}-agent"
  res_id                 = local.agent_res_id
  env_type               = each.value.env_type_id
  app_id                 = var.app_id
  force_delete           = true
}