resource "humanitec_resource_definition" "vertex_ai" {
  driver_type = "humanitec/echo"
  id          = "vertex-ai"
  name        = "vertex-ai"
  type        = "gcp-vertex-ai"
  driver_inputs = {
    values_string = jsonencode({
      "project"  = "$${resources['config.default#app'].outputs.gcp_project_id}"
      "location" = "$${resources['config.default#app'].outputs.gcp_region}"
    })
  }
  provision = {
    "gcp-iam-policy-binding.vertex-ai-default" = {
      is_dependent     = true
      match_dependents = false
    }
  }
}

resource "humanitec_resource_definition_criteria" "vertex_ai" {
  resource_definition_id = resource.humanitec_resource_definition.vertex_ai.id
}