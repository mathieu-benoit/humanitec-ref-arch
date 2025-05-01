resource "humanitec_environment_type" "env_type" {
  for_each = { for env_type in var.env_types : env_type.id => env_type }

  id          = each.value.id
  description = each.value.description
}