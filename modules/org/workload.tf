resource "humanitec_resource_definition" "workload" {
  driver_type = "humanitec/template"
  id          = "workload"
  name        = "workload"
  type        = "workload"

  driver_inputs = {
    values_string = jsonencode({
      templates = {
        init      = ""
        manifests = ""
        outputs   = file("${path.module}/manifests/workload/outputs.gtpl")
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "workload" {
  resource_definition_id = humanitec_resource_definition.workload.id
  force_delete           = true
}
