locals {
  apphub_app_resource_type = "gcp-apphub-app"
}

/*resource "terracurl_request" "apphub_app_resource_type" {
  name = "apphub_app_resource_type"

  url            = "https://api.humanitec.io/orgs/${var.org_id}/resources/types"
  method         = "POST"
  response_codes = ["200", "409"]
  request_body   = jsonencode(yamldecode(templatefile("${path.module}/resource-types/apphub-app.yaml", { org_id = var.org_id, resource_type = local.apphub_app_resource_type })))
  headers = {
    "Authorization" = "Bearer ${var.token}"
    "Content-Type"  = "application/json"
  }

  destroy_url            = "https://api.humanitec.io/orgs/${var.org_id}/resources/types/${var.org_id}%2F${local.apphub_app_resource_type}"
  destroy_method         = "DELETE"
  destroy_response_codes = ["204"]
  destroy_headers = {
    "Authorization" = "Bearer ${var.token}"
    "Content-Type"  = "application/json"
  }
}*/