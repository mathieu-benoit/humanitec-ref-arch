resource "google_compute_ssl_policy" "external_gateway" {
  name            = local.external_gateway_name
  profile         = "RESTRICTED"
  min_tls_version = "TLS_1_2"
}

resource "kubernetes_manifest" "external_ssl_policy" {
  manifest = yamldecode(templatefile("${path.module}/manifests/external-ssl-policy.yaml",
    {
      gateway_name      = local.external_gateway_name,
      gateway_namespace = local.external_gateway_name
  }))
}