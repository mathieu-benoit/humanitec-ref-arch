locals {
  # FIXME - replace with datasource
  humanitec_operator_k8s_sa_name = "humanitec-operator-controller-manager"
}

resource "tls_private_key" "operator" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "kubernetes_namespace" "humanitec_operator" {
  metadata {
    labels = {
      "pod-security.kubernetes.io/enforce" = "restricted"
    }

    name = "humanitec-operator-system"
  }
}

resource "helm_release" "humanitec_operator" {
  name       = "humanitec-operator"
  namespace  = kubernetes_namespace.humanitec_operator.metadata[0].name
  repository = "oci://ghcr.io/humanitec/charts"
  chart      = "humanitec-operator"
  version    = "0.7.0"
  wait       = true
  timeout    = 300

  set = [
    {
      name  = "controllerManager.kubeRbacProxy.image.repository"
      value = "gcr.io/kubebuilder/kube-rbac-proxy"
    },
    {
      name  = "controllerManager.manager.image.repository"
      value = "ghcr.io/humanitec/operator"
    },
    {
      name  = "controllerManager.podSecurityContext.fsGroup"
      value = "65532"
    },
    {
      name  = "controllerManager.podSecurityContext.runAsGroup"
      value = "65532"
    },
    {
      name  = "controllerManager.podSecurityContext.runAsUser"
      value = "65532"
    }
  ]
}

resource "kubernetes_secret" "humanitec_operator" {
  metadata {
    name      = "humanitec-operator-private-key"
    namespace = kubernetes_namespace.humanitec_operator.metadata[0].name
  }

  data = {
    privateKey              = tls_private_key.operator.private_key_pem
    humanitecOrganisationID = var.org_id
  }
}

# Access from Humanitec Operator by the default secret store
resource "google_project_iam_custom_role" "default_secretstore" {
  role_id     = "secretmanager.readwrite"
  title       = "Secret Reader/Writer"
  description = "Can create new and update existing secrets and read them"
  permissions = [
    "secretmanager.secrets.create",
    "secretmanager.secrets.delete",
    "secretmanager.secrets.update",
    "secretmanager.versions.list",
    "secretmanager.versions.add",
    "secretmanager.versions.access"
  ]
}
resource "google_project_iam_member" "default_secretstore" {
  project = var.project_id
  role    = "projects/${var.project_id}/roles/${google_project_iam_custom_role.default_secretstore.role_id}"
  member  = "principal://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${var.project_id}.svc.id.goog/subject/ns/${kubernetes_namespace.humanitec_operator.metadata.0.name}/sa/${local.humanitec_operator_k8s_sa_name}"
}
resource "kubernetes_manifest" "default_secretstore" {
  count = var.humanitec_crds_already_installed ? 1 : 0

  manifest = {
    "apiVersion" = "humanitec.io/v1alpha1"
    "kind"       = "SecretStore"
    "metadata" = {
      "name"      = "default"
      "namespace" = kubernetes_namespace.humanitec_operator.metadata[0].name
      "labels" = {
        "app.humanitec.io/default-store" = "true"
      }
    }
    "spec" = {
      "gcpsm" = {
        "projectID" = "${var.project_id}"
        "auth"      = {}
      }
    }
  }
  depends_on = [helm_release.humanitec_operator]
}