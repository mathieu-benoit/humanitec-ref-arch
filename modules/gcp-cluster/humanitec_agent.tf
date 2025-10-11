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

  set = [
    {
      name  = "humanitec.org"
      value = var.org_id
    },
    {
      name  = "podSecurityContext.fsGroup"
      value = "65532"
    },
    {
      name  = "podSecurityContext.runAsGroup"
      value = "65532"
    },
    {
      name  = "podSecurityContext.runAsUser"
      value = "65532"
    },
    {
      name  = "image.repository"
      value = "ghcr.io/humanitec/agent"
    }
  ]

  set_sensitive = [
    {
      name  = "humanitec.privateKey"
      value = tls_private_key.agent.private_key_pem
    }
  ]
}

resource "kubernetes_network_policy" "humanitec_agent_deny_all" {
  metadata {
    name      = "deny-all"
    namespace = kubernetes_namespace.humanitec_agent.metadata[0].name
  }

  spec {
    pod_selector {}

    policy_types = ["Ingress", "Egress"]
  }
}

resource "kubernetes_network_policy" "humanitec_agent_egress" {
  metadata {
    name      = "egress-from-humanitec-agent"
    namespace = kubernetes_namespace.humanitec_agent.metadata[0].name
  }

  spec {
    pod_selector {
      match_labels = {
        "app.kubernetes.io/name" = "humanitec-agent"
      }
    }

    egress {
      to {
        ip_block {
          cidr = "0.0.0.0/0"
        }
      }
      ports {
        port     = "443"
        protocol = "TCP"
      }
    }

    egress {
      to {
        ip_block {
          cidr = "169.254.20.10/32" /* NodeLocal DNSCache with Cloud DNS */
        }
      }
      ports {
        port     = "53"
        protocol = "TCP"
      }
      ports {
        port     = "53"
        protocol = "UDP"
      }
    }

    policy_types = ["Egress"]
  }
}