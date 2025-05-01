resource "humanitec_resource_definition" "ingress_internal" {
  id          = "ingress-internal"
  name        = "ingress-internal"
  type        = "ingress"
  driver_type = "humanitec/ingress"
  driver_inputs = {
    values_string = jsonencode({
      "class" : "nginx-internal"
      "path_type" : "ImplementationSpecific"
      "no_tls" : true
    })
  }
}

resource "humanitec_resource_definition_criteria" "ingress_default" {
  resource_definition_id = humanitec_resource_definition.ingress_internal.id
  class                  = "default"
}

resource "humanitec_resource_definition_criteria" "ingress_internal" {
  resource_definition_id = humanitec_resource_definition.ingress_internal.id
  class                  = humanitec_resource_class.internal_dns.id
}