resource "humanitec_resource_account" "cloud_account" {
  id   = var.name
  name = var.name
  type = "aws-role"
  credentials = jsonencode({
    aws_role    = var.cloud_account.aws_role
    external_id = var.cloud_account.external_id
    sts_region  = var.aws_region
  })
}