resource "tls_private_key" "agent" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "humanitec_agent" "agent" {
  id          = "${var.name}-agent"
  description = "${var.name}-agent"
  public_keys = [
    {
      key = tls_private_key.agent.public_key_pem
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
// Note: no matching criteria defined at the Value Chain level, it will be defined at the App Level.