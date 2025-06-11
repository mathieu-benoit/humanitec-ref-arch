output "service_users_tokens" {
  value     = [for app in module.apps : app.service_users_tokens]
  sensitive = true
}
// TODO: another way to avoid storing this sensitive info in TF State, could be to store it in your Secret Manager.