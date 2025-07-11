output "operator_public_key" {
  value     = tls_private_key.operator.public_key_pem
  sensitive = true
}

output "agent_public_key" {
  value     = tls_private_key.agent.public_key_pem
  sensitive = true
}

output "load_balancer" {
  value = google_compute_global_address.external_gateway.address
}

output "gcp_wi_pool_provider_name" {
  value = google_iam_workload_identity_pool_provider.gke_cluster_access.name
}

output "gcp_wi_pool_name" {
  value = google_iam_workload_identity_pool.gke_cluster_access.name
}

output "cluster_access_gsa_email" {
  value     = google_service_account.gke_cluster_access.email
  sensitive = true
}

output "cloud_account_id" {
  value = google_service_account.gke_cluster_access.account_id
}

output "project_number" {
  value = data.google_project.project.number
}

output "external_gateway_name" {
  value = local.external_gateway_name
}

output "external_security_policy_name" {
  value = google_compute_security_policy.external_gateway.name
}