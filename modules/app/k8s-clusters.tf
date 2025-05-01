// Assuming that the "${each.value.name}-cluster" res def is already created by the cluster module.
resource "humanitec_resource_definition_criteria" "eks" {
  for_each = { for cluster in var.clusters : cluster.cluster_name => cluster }

  resource_definition_id = "${each.value.cluster_name}-cluster"
  force_delete           = true
  app_id                 = var.app_id
  env_type               = each.value.env_type_id
}