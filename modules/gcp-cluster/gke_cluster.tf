data "google_container_cluster" "gke_cluster" {
  name     = var.cluster_name
  location = var.region
  project  = var.project_id
}

resource "google_service_account" "gke_cluster_access" {
  account_id  = var.cluster_name
  description = "Account used by Humanitec to access the ${var.cluster_name} GKE cluster"
}
resource "google_project_iam_custom_role" "gke_cluster_access" {
  role_id     = "humanitec.gkeaccess"
  title       = "Humanitec GKE access"
  description = "Can deploy Kubernetes resources from Humanitec to GKE cluster."
  permissions = [
    "container.clusters.get"
  ]
}
resource "kubernetes_cluster_role" "humanitec_deploy_access" {
  metadata {
    name = "humanitec-deploy-access"
  }

  # Namespaces management
  rule {
    api_groups = [""]
    resources  = ["namespaces"]
    verbs      = ["create", "get", "list", "update", "patch", "delete"]
  }

  # Humanitec's CRs management.
  rule {
    api_groups = ["humanitec.io"]
    resources  = ["resources", "secretmappings", "workloadpatches", "workloads"]
    verbs      = ["create", "get", "list", "update", "patch", "delete", "deletecollection", "watch"]
  }

  # Deployment / Workload Status in UI
  rule {
    api_groups = ["batch"]
    resources  = ["jobs"]
    verbs      = ["get", "list"]
  }
  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "statefulsets", "replicasets", "daemonsets"]
    verbs      = ["get", "list"]
  }
  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list"]
  }

  # Container's logs in UI
  rule {
    api_groups = [""]
    resources  = ["pods/log"]
    verbs      = ["get", "list"]
  }

  # Pause Environments
  rule {
    api_groups = ["apps"]
    resources  = ["deployments/scale"]
    verbs      = ["update"]
  }

  # To get the active resources (resources outputs)
  rule {
    api_groups = [""]
    resources  = ["configmaps"]
    verbs      = ["get"]
  }
}
resource "kubernetes_cluster_role_binding" "humanitec_deploy_access" {
  metadata {
    name = "humanitec-deploy-access"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.humanitec_deploy_access.metadata.0.name
  }
  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "User"
    name      = google_service_account.gke_cluster_access.email
  }
}
resource "google_project_iam_member" "gke_cluster_access" {
  project = var.project_id
  role    = "projects/${var.project_id}/roles/${google_project_iam_custom_role.gke_cluster_access.role_id}"
  member  = "serviceAccount:${google_service_account.gke_cluster_access.email}"
}
resource "google_iam_workload_identity_pool" "gke_cluster_access" {
  workload_identity_pool_id = var.cluster_name
}
resource "google_iam_workload_identity_pool_provider" "gke_cluster_access" {
  display_name                       = var.cluster_name
  workload_identity_pool_id          = google_iam_workload_identity_pool.gke_cluster_access.workload_identity_pool_id
  workload_identity_pool_provider_id = var.cluster_name
  attribute_mapping = {
    "google.subject" = "assertion.sub"
  }
  oidc {
    issuer_uri = "https://idtoken.humanitec.io"
  }
}
resource "google_service_account_iam_member" "gke_cluster_access" {
  service_account_id = google_service_account.gke_cluster_access.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principal://iam.googleapis.com/${google_iam_workload_identity_pool.gke_cluster_access.name}/subject/${var.org_id}/${google_service_account.gke_cluster_access.account_id}"
}
