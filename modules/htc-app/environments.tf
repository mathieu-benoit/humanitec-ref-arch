resource "humanitec_environment" "env" {
  for_each = { for env in var.envs : env.id => env }

  app_id = humanitec_application.app.id
  id     = each.value.id
  name   = each.value.name
  type   = each.value.type
}