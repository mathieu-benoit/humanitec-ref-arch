resource "humanitec_resource_account" "cloud_account" {
  count = var.app_id == "online-boutique" ? 1 : 0

  id   = var.cloud_account_id
  name = var.cloud_account_id
  type = "gcp-identity"

  credentials = jsonencode({
    gcp_service_account = var.cloud_account_gsa_email
    gcp_audience        = "//iam.googleapis.com/${var.gcp_wi_pool_provider_name}"
  })
}