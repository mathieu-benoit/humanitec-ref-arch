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