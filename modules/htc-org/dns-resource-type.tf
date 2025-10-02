resource "humanitec_resource_type" "dns" {
  id       = "${var.org_id}/dns"
  name     = "DNS"
  category = "dns"
  use      = "direct"
  inputs_schema = jsonencode({
    "additionalProperties" : false,
    "type" : "object"
  })
  outputs_schema = jsonencode({
    "properties" : {
      "values" : {
        "properties" : {
          "host" : {
            "description" : "The DNS name returned by the driver.",
            "title" : "DNS Name",
            "type" : "string"
          },
          "url" : {
            "description" : "The DNS URL returned by the driver.",
            "title" : "DNS URL",
            "type" : "string"
          }
        },
        "required" : ["host", "url"],
        "type" : "object"
      }
    },
    "type" : "object"
  })
}