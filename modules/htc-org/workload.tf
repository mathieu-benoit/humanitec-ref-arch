resource "humanitec_resource_definition" "workload" {
  driver_type = "humanitec/template"
  id          = "custom-workload"
  name        = "custom-workload"
  type        = "workload"

  driver_inputs = {
    values_string = jsonencode(yamldecode(file("${path.module}/manifests/workload/definition-values.yaml")))
  }

  #provision = {
  #  "${var.org_id}/gcp-apphub-workload" = {
  #    is_dependent = true
  #  }
  #}
}

resource "humanitec_resource_definition_criteria" "workload" {
  resource_definition_id = humanitec_resource_definition.workload.id
  force_delete           = true
}
