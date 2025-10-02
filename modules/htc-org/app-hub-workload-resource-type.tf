resource "humanitec_resource_type" "apphub_workload" {
  id       = "${var.org_id}/gcp-apphub-workload"
  name     = "Google Cloud AppHub Workload"
  category = ""
  use      = "indirect"
  inputs_schema = jsonencode({
    "additionalProperties" : false,
    "type" : "object"
  })
  outputs_schema = jsonencode({
    "additionalProperties" : false,
    "type" : "object"
  })
}