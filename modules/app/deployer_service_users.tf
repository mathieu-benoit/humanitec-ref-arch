resource "humanitec_user" "service_user" {
  for_each = { for cluster in var.clusters : cluster.cluster_name => cluster }

  name = "su-${each.value.cluster_name}"
  role = "member"
  type = "service"
}

resource "humanitec_application_user" "service_user" {
  for_each = { for cluster in var.clusters : cluster.cluster_name => cluster }

  app_id  = var.app_id
  user_id = humanitec_user.service_user[each.key].id
  role    = "developer"
}

resource "humanitec_environment_type_user" "service_user" {
  for_each = { for cluster in var.clusters : cluster.cluster_name => cluster }

  env_type_id = each.value.env_type_id
  user_id     = humanitec_user.service_user[each.key].id
  role        = "deployer"
}

resource "humanitec_service_user_token" "service_user" {
  for_each = { for cluster in var.clusters : cluster.cluster_name => cluster }

  id          = humanitec_user.service_user[each.key].id
  user_id     = humanitec_user.service_user[each.key].id
  description = humanitec_user.service_user[each.key].name
  expires_at  = "2024-12-23T21:59:59.999Z" // TODO: Find another way to not hard code this here
}