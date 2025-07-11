locals {
  external_gateway_name = "external-gateway"
}

resource "google_compute_global_address" "external_gateway" {
  project      = var.project_id
  name         = "${var.cluster_name}-external"
  address_type = "EXTERNAL"
}

resource "kubernetes_namespace" "external_gateway" {
  metadata {
    labels = {
      "pod-security.kubernetes.io/enforce" = "restricted"
    }

    name = local.external_gateway_name
  }
}

resource "tls_private_key" "external_gateway" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "external_gateway" {
  private_key_pem = tls_private_key.external_gateway.private_key_pem

  subject {
    common_name = "*.endpoints.${var.project_id}.cloud.goog"
  }

  validity_period_hours = 1460

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "kubernetes_manifest" "external_gateway" {
  manifest = yamldecode(templatefile("${path.module}/manifests/external-gateway.yaml",
    {
      gateway_name      = local.external_gateway_name,
      gateway_namespace = local.external_gateway_name,
      project_id        = var.project_id,
      gateway_ip_name   = google_compute_global_address.external_gateway.name
  }))
}

resource "kubernetes_manifest" "external_tls_secret" {
  manifest = yamldecode(templatefile("${path.module}/manifests/external-tls-secret.yaml",
    {
      gateway_name      = local.external_gateway_name,
      gateway_namespace = local.external_gateway_name,
      tls_crt           = base64encode(tls_self_signed_cert.external_gateway.cert_pem)
      tls_key           = base64encode(tls_self_signed_cert.external_gateway.private_key_pem)
  }))
}

resource "kubernetes_manifest" "external_gateway_http_to_https_redirect" {
  manifest = yamldecode(templatefile("${path.module}/manifests/external-gateway-http-to-https-redirect.yaml",
    {
      gateway_name      = local.external_gateway_name,
      gateway_namespace = local.external_gateway_name
  }))
}