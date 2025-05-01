output "service_users_tokens" {
  value     = [for app in module.apps : app.service_users_tokens]
  sensitive = true
}
// TODO: another way to avoid storing this sensitive info in TF State, could be to store it in your Secret Manager.

/*output "operator_private_keys" {
  value     = [for cluster in module.clusters : cluster.operator_private_key]
  sensitive = true
}
// TODO: another way to avoid storing this sensitive info in TF State, could be to store it in your Secret Manager.

output "agent_private_keys" {
  value     = [for cluster in module.clusters : cluster.agent_private_key]
  sensitive = true
}
// TODO: another way to avoid storing this sensitive info in TF State, could be to store it in your Secret Manager.

output "cloud_accounts_ids" {
  value     = [for cluster in module.clusters : cluster.cloud_account_id]
  sensitive = true
}*/