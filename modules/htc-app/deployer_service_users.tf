resource "humanitec_user" "service_user" {
  for_each = { for env_type in var.env_types : env_type.id => env_type }

  name = "su-${var.app_id}-${each.value.id}"
  role = each.value.id == "development" ? "artefactContributor" : "member"
  type = "service"
}

resource "humanitec_application_user" "service_user" {
  for_each = { for env_type in var.env_types : env_type.id => env_type }

  app_id  = var.app_id
  user_id = humanitec_user.service_user[each.key].id
  role    = "developer"
}

resource "humanitec_environment_type_user" "service_user" {
  for_each = { for env_type in var.env_types : env_type.id => env_type }

  env_type_id = each.value.id
  user_id     = humanitec_user.service_user[each.key].id
  role        = "deployer"
}

resource "humanitec_service_user_token" "service_user" {
  for_each = { for env_type in var.env_types : env_type.id => env_type }

  id          = humanitec_user.service_user[each.key].id
  user_id     = humanitec_user.service_user[each.key].id
  description = humanitec_user.service_user[each.key].name
  expires_at  = "2025-12-23T21:59:59.999Z" // TODO: Find another way to not hard code this here
}