output "operator_private_key" {
  value     = tls_private_key.operator.private_key_pem
  sensitive = true
}

output "agent_private_key" {
  value     = tls_private_key.agent.private_key_pem
  sensitive = true
}

output "cloud_account_id" {
  value = humanitec_resource_account.cloud_account.id
}