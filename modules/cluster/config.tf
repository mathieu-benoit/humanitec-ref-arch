resource "humanitec_resource_definition" "cluster_config" {
  driver_account = humanitec_resource_account.cloud_account.id
  driver_type    = "humanitec/echo"
  id             = "${var.name}-config"
  name           = "${var.name}-config"
  type           = "config"
  driver_inputs = {
    values_string = jsonencode({
      "env_type"                    = var.env_type_id
      "aws_region"                  = var.aws_region
      "dns_internal_hosted_zone_id" = var.load_balancer_hosted_zone
    })
  }
}
// Note: no matching criteria defined at the Value Chain level, it will be defined at the App Level.