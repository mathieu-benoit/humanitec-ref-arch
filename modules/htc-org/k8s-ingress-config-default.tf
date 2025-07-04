resource "humanitec_resource_definition" "ingress_config_default" {
  driver_type = "humanitec/template"
  id          = "ingress-config-default"
  name        = "ingress-config-default"
  type        = "config"

  driver_inputs = {
    values_string = jsonencode(yamldecode(file("${path.module}/manifests/k8s-ingress-config-default/definition-values.yaml")))
  }
}

resource "humanitec_resource_definition_criteria" "ingress_config_default" {
  resource_definition_id = humanitec_resource_definition.ingress_config_default.id
  class                  = "default"
  res_id                 = "ingress"
  force_delete           = true
}

resource "humanitec_resource_definition_criteria" "ingress_config_internal" {
  resource_definition_id = humanitec_resource_definition.ingress_config_default.id
  class                  = "internal"
  res_id                 = "ingress"
  force_delete           = true
}