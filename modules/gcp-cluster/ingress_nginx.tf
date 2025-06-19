resource "google_compute_address" "public_ingress" {
  project      = var.project_id
  name         = var.cluster_name
  address_type = "EXTERNAL"
  region       = var.region
}

resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    labels = {
      "pod-security.kubernetes.io/enforce" = "restricted"
    }

    name = "ingress-nginx"
  }
}

resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  namespace  = kubernetes_namespace.ingress_nginx.metadata.0.name
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.12.3"
  wait       = true
  timeout    = 300

  set = [
    {
      name  = "controller.service.loadBalancerIP"
      value = google_compute_address.public_ingress.address
    },
    {
      name  = "controller.containerSecurityContext.runAsUser"
      value = 101
    },
    {
      name  = "controller.containerSecurityContext.runAsGroup"
      value = 101
    },
    {
      name  = "controller.containerSecurityContext.allowPrivilegeEscalation"
      value = false
    },
    {
      name  = "controller.containerSecurityContext.readOnlyRootFilesystem"
      value = false
    },
    {
      name  = "controller.containerSecurityContext.runAsNonRoot"
      value = true
    }
  ]

  set_list = [
    {
      name  = "controller.containerSecurityContext.capabilities.drop"
      value = ["ALL"]
    },
    {
      name  = "controller.containerSecurityContext.capabilities.add"
      value = ["NET_BIND_SERVICE"]
    }
  ]
}