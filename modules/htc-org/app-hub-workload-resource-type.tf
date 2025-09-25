/*
  humctl get resource-type | grep ${HUMANITEC_ORG}

  humctl delete res-def apphub-workload
  
  humctl get resource-type -o json | jq -r ".[] | select(.metadata.type == \"${HUMANITEC_ORG}/gcp-apphub-workload\")"

  humctl api delete /orgs/${HUMANITEC_ORG}/resources/types/${HUMANITEC_ORG}%2Fgcp-apphub-workload

  terraform state rm module.org.humanitec_resource_definition_criteria.apphub_workload
*/

locals {
  apphub_workload_resource_type = "gcp-apphub-workload"
}

resource "terracurl_request" "apphub_workload_resource_type" {
  name = "apphub_workload_resource_type"

  url            = "https://api.humanitec.io/orgs/${var.org_id}/resources/types"
  method         = "POST"
  response_codes = ["200", "409"]
  request_body = jsonencode(yamldecode(templatefile("${path.module}/resource-types/apphub-workload.yaml",
    {
      org_id        = var.org_id,
      resource_type = local.apphub_workload_resource_type
  })))
  headers = {
    "Authorization" = "Bearer ${var.token}"
    "Content-Type"  = "application/json"
  }

  destroy_url            = "https://api.humanitec.io/orgs/${var.org_id}/resources/types/${var.org_id}%2F${local.apphub_workload_resource_type}"
  destroy_method         = "DELETE"
  destroy_response_codes = ["204"]
  destroy_headers = {
    "Authorization" = "Bearer ${var.token}"
    "Content-Type"  = "application/json"
  }
}