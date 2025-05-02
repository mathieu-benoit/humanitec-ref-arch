resource "humanitec_resource_definition" "k8s_cluster" {
  driver_type = "humanitec/k8s-cluster-gke"
  id          = "${var.id}-cluster"
  name        = "${var.id}-cluster"
  type        = "k8s-cluster"
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
  resource_definition_id = humanitec_resource_definition.k8s_cluster.id
  env_type               = var.env_type

  force_delete = true
}