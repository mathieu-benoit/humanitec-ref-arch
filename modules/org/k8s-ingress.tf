resource "humanitec_resource_definition" "ingress" {
  driver_type = "humanitec/ingress"
  id          = "custom-ingress"
  name        = "custom-ingress"
  type        = "ingress"
  driver_inputs = {
    values_string = jsonencode({
      "class" = "nginx"
    })
  }
}

resource "humanitec_resource_definition_criteria" "ingress" {
  resource_definition_id = humanitec_resource_definition.ingress.id
  force_delete           = true
}