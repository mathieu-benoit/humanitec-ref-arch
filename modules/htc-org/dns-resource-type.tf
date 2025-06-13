/*locals {
  dns_resource_type = "dns"
}

resource "terracurl_request" "dns_resource_type" {
  name = "dns_resource_type"

  url            = "https://api.humanitec.io/orgs/${var.org_id}/resources/types"
  method         = "POST"
  response_codes = ["200", "409"]
  request_body   = jsonencode(yamldecode(templatefile("${path.module}/resource-types/dns.yaml", { org_id = var.org_id, resource_type = local.dns_resource_type })))
  headers = {
    "Authorization" = "Bearer ${var.token}"
    "Content-Type"  = "application/json"
  }

  destroy_url            = "https://api.humanitec.io/orgs/${var.org_id}/resources/types/${var.org_id}%2F${local.dns_resource_type}"
  destroy_method         = "DELETE"
  destroy_response_codes = ["204"]
  destroy_headers = {
    "Authorization" = "Bearer ${var.token}"
    "Content-Type"  = "application/json"
  }
}*/