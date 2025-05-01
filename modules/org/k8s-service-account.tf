resource "humanitec_resource_definition" "k8s_service_account" {
  driver_type = "humanitec/template"
  id          = "k8s-service-account"
  name        = "k8s-service-account"
  type        = "k8s-service-account"

  driver_inputs = {
    values_string = jsonencode({
      templates = {
        init      = file("${path.module}/manifests/k8s-service-account/init.gtpl")
        manifests = file("${path.module}/manifests/k8s-service-account/manifests.gtpl")
        outputs   = file("${path.module}/manifests/k8s-service-account/outputs.gtpl")
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "k8s_service_account" {
  resource_definition_id = humanitec_resource_definition.k8s_service_account.id
  force_delete           = true
}
