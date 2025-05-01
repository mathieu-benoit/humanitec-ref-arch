resource "humanitec_resource_definition" "eks" {
  driver_type    = "humanitec/k8s-cluster-eks"
  id             = "${var.name}-cluster"
  name           = "${var.name}-cluster"
  type           = "k8s-cluster"
  driver_account = humanitec_resource_account.cloud_account.id
  driver_inputs = {
    values_string = jsonencode({
      "region"                   = var.aws_region
      "name"                     = var.name
      "loadbalancer"             = var.load_balancer
      "loadbalancer_hosted_zone" = var.load_balancer_hosted_zone
    }),
    secrets_string = jsonencode({
      "agent_url" = "$${resources['agent#agent'].outputs.url}"
    })
  }
}
// Note: no matching criteria defined at the Value Chain level, it will be defined at the App Level.