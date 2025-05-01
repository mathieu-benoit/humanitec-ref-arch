module "org" {
  source = "./modules/org"

  env_types = var.env_types
}

/*module "clusters" {
  for_each = { for cluster in var.clusters : cluster.name => cluster }

  source = "./modules/cluster"

  aws_region                = each.value.aws_region
  name                      = each.value.name
  cloud_account             = each.value.cloud_account
  env_type_id               = each.value.env_type_id
  load_balancer             = each.value.load_balancer
  load_balancer_hosted_zone = each.value.load_balancer_hosted_zone
}

locals {
  clusters = [
    for i in range(length(var.clusters)) : {
      "env_type_id" : var.clusters[i].env_type_id,
      "cluster_name" : var.clusters[i].name
    }
  ]
}*/

module "apps" {
  for_each = { for app in var.apps : app.id => app }

  source = "./modules/app"

  app_id       = each.value.id
  app_name     = each.value.name
  #clusters     = local.clusters
  viewer_users = each.value.viewer_users

  #depends_on = [module.org, module.clusters]
  depends_on = [module.org]
}