resource "humanitec_resource_definition" "k8s_namespace" {
  driver_type = "humanitec/template"
  id          = "custom-namespace"
  name        = "custom-namespace"
  type        = "k8s-namespace"

  driver_inputs = {
    values_string = jsonencode(yamldecode(file("${path.module}/manifests/k8s-namespace/definition-values.yaml")))
  }
}

resource "humanitec_resource_definition_criteria" "k8s_namespace" {
  resource_definition_id = humanitec_resource_definition.k8s_namespace.id
  force_delete           = true
}