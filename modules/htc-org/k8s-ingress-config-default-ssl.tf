resource "humanitec_resource_definition" "ingress_config_ssl" {
  driver_type = "humanitec/template"
  id          = "ingress-config-ssl"
  name        = "ingress-config-ssl"
  type        = "config"

  driver_inputs = {
    values_string = jsonencode(yamldecode(file("${path.module}/manifests/k8s-ingress-config-ssl/definition-values.yaml")))
  }
}

resource "humanitec_resource_definition_criteria" "ingress_config_ssl" {
  resource_definition_id = humanitec_resource_definition.ingress_config_ssl.id
  class                  = "ssl"
  res_id                 = "ingress"
  force_delete           = true
}