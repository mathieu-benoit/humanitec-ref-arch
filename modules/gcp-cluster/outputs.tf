output "operator_public_key" {
  value     = tls_private_key.operator.public_key_pem
  sensitive = true
}

output "agent_public_key" {
  value     = tls_private_key.agent.public_key_pem
  sensitive = true
}

output "load_balancer" {
  value = google_compute_address.public_ingress.address

  depends_on = [helm_release.ingress_nginx]
}

output "gcp_wi_pool_provider_name" {
  value     = google_iam_workload_identity_pool_provider.gke_cluster_access.name
  sensitive = true
}

output "cluster_access_gsa_email" {
  value     = google_service_account.gke_cluster_access.email
  sensitive = true
}

output "cloud_account_id" {
  value = google_service_account.gke_cluster_access.account_id
}