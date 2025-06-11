resource "humanitec_agent" "agent" {
  id          = "${var.id}-agent"
  description = "${var.id}-agent"
  public_keys = [
    {
      key = var.agent_public_key
    }
  ]
}

resource "humanitec_resource_definition" "agent" {
  id          = humanitec_agent.agent.id
  name        = humanitec_agent.agent.id
  type        = "agent"
  driver_type = "humanitec/agent"
  driver_inputs = {
    values_string = jsonencode({
      id = humanitec_agent.agent.id
    })
  }
}

resource "humanitec_resource_definition_criteria" "agent" {
  for_each = { for env_type in var.env_types : env_type.id => env_type }

  resource_definition_id = humanitec_resource_definition.agent.id
  env_type               = each.value.id
  res_id                 = "agent"

  force_delete = true
}