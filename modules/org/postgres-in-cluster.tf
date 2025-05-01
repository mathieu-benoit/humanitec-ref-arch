resource "humanitec_resource_definition" "postgres_in_cluster" {
  id          = "postgres-in-cluster"
  name        = "postgres-in-cluster"
  type        = "postgres"
  driver_type = "humanitec/template"

  driver_inputs = {
    values_string = jsonencode(yamldecode(file("${path.module}/manifests/postgres/definition-values.yaml")))
  }
}

resource "humanitec_resource_definition_criteria" "postgres_in_cluster" {
  resource_definition_id = humanitec_resource_definition.postgres_in_cluster.id
  force_delete           = true
}