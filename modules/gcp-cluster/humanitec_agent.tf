resource "tls_private_key" "agent" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "kubernetes_namespace" "humanitec_agent" {
  metadata {
    labels = {
      "pod-security.kubernetes.io/enforce" = "restricted"
    }

    name = "humanitec-agent"
  }
}

resource "helm_release" "humanitec_agent" {
  name       = "humanitec-agent"
  namespace  = kubernetes_namespace.humanitec_agent.metadata[0].name
  repository = "oci://ghcr.io/humanitec/charts"
  chart      = "humanitec-agent"
  version    = "1.2.10"
  wait       = true
  timeout    = 300

  set {
    name  = "humanitec.org"
    value = var.org_id
  }

  set {
    name  = "podSecurityContext.fsGroup"
    value = "65532"
  }

  set {
    name  = "podSecurityContext.runAsGroup"
    value = "65532"
  }

  set {
    name  = "podSecurityContext.runAsUser"
    value = "65532"
  }

  set_sensitive {
    name  = "humanitec.privateKey"
    value = tls_private_key.agent.private_key_pem
  }

  set {
    name  = "image.repository"
    value = "ghcr.io/humanitec/agent"
  }
}