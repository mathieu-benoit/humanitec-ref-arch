resource "humanitec_resource_definition" "httproute" {
  driver_type = "humanitec/template"
  id          = "httproute"
  name        = "httproute"
  type        = "ingress"

  driver_inputs = {
    values_string = jsonencode(yamldecode(file("${path.module}/manifests/ingress/definition-values.yaml")))
  }
}

resource "humanitec_resource_definition_criteria" "httproute" {
  resource_definition_id = humanitec_resource_definition.httproute.id
  force_delete           = true
}