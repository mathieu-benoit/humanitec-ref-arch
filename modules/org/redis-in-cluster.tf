resource "humanitec_resource_definition" "main" {
  id          = "redis-in-cluster"
  name        = "edis-in-cluster"
  type        = "redis"
  driver_type = "humanitec/template"

  driver_inputs = {
    values_string = jsonencode(yamldecode(file("${path.module}/manifests/redis/definition-values.yaml")))
  }
}