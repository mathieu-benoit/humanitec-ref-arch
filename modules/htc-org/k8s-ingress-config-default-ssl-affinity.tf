resource "humanitec_resource_definition" "ingress_config_ssl_affinity" {
  driver_type = "humanitec/template"
  id          = "ingress-config-ssl-affinity"
  name        = "ingress-config-ssl-affinity"
  type        = "config"

  driver_inputs = {
    values_string = jsonencode(yamldecode(file("${path.module}/manifests/k8s-ingress-config-ssl-affinity/definition-values.yaml")))
  }
}

resource "humanitec_resource_definition_criteria" "ingress_config_ssl_affinity" {
  resource_definition_id = humanitec_resource_definition.ingress_config_ssl_affinity.id
  class                  = "ssl-affinity"
  res_id                 = "ingress"
  force_delete           = true
}