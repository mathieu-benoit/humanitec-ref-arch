resource "humanitec_resource_account" "cluster_account" {
  id   = var.id
  name = var.id
  type = "gcp-identity"

  credentials = jsonencode({
    gcp_service_account = var.cluster_access_gsa_email
    gcp_audience        = "//iam.googleapis.com/${var.gcp_wi_pool_provider_name}"
  })
}