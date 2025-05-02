resource "humanitec_environment_type" "env_type" {
  for_each = { for env_type in var.env_types : env_type.id => env_type if env_type.id != var.env_types[0].id }

  id          = each.value.id
  description = each.value.description
}