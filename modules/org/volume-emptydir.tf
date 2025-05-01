resource "humanitec_resource_definition" "emptydir_volume" {
  driver_type = "humanitec/template"
  id          = "volume-emptydir"
  name        = "volume-emptydir"
  type        = "volume"
  driver_inputs = {
    values_string = jsonencode(yamldecode(file("${path.module}/manifests/volume/definition-values.yaml")))
  }
}

resource "humanitec_resource_definition_criteria" "emptydir_volume" {
  resource_definition_id = humanitec_resource_definition.emptydir_volume.id
  force_delete           = true
}