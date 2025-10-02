resource "humanitec_resource_type" "apphub_app" {
  id       = "${var.org_id}/gcp-apphub-app"
  name     = "Google Cloud AppHub Application"
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