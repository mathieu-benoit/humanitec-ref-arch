resource "humanitec_resource_definition" "base-env" {
  driver_type = "humanitec/template"
  id          = "base-env"
  name        = "base-env"
  type        = "base-env"
  driver_inputs = {
    values_string = jsonencode(yamldecode(file("${path.module}/manifests/base-env/definition-values.yaml")))
  }
}

resource "humanitec_resource_definition_criteria" "base-env" {
  resource_definition_id = resource.humanitec_resource_definition.base-env.id
  force_delete           = true
}