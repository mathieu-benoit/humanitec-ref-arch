data "humanitec_users" "member" {
  for_each = { for user in var.viewer_users : user.email => user }

  filter = {
    email = each.value.email
  }
}

locals {
  existing_members = {
    for user in data.humanitec_users.member : user.id => {
      user_id = user.users[0].id
    }
    if user.id > 0
  }
}

resource "humanitec_application_user" "viewer" {
  for_each = local.existing_members

  app_id  = humanitec_application.app.id
  user_id = each.value.user_id
  role    = "viewer"
}