resource "humanitec_resource_definition" "k8s_cluster" {
  driver_type    = "humanitec/k8s-cluster-gke"
  id             = "${var.id}-cluster"
  name           = "${var.id}-cluster"
  type           = "k8s-cluster"
  driver_account = humanitec_resource_account.cluster_account.id
  driver_inputs = {
    values_string = jsonencode({
      "zone"         = var.region
      "name"         = var.name
      "loadbalancer" = var.load_balancer
      "project_id"   = var.project_id
    }),
    secrets_string = jsonencode({
      "agent_url" = "$${resources['agent#agent'].outputs.url}"
    })
  }
}

resource "humanitec_resource_definition_criteria" "k8s_cluster" {
  for_each = { for env_type in var.env_types : env_type.id => env_type }
  
  resource_definition_id = humanitec_resource_definition.k8s_cluster.id
  env_type               = each.value.id

  force_delete = true
}