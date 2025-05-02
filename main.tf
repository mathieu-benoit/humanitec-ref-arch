module "org" {
  source = "./modules/htc-org"

  env_types = var.env_types
}

module "gcp_cluster" {
  source = "./modules/gcp-cluster"

  org_id                           = var.org_id
  cluster_name                     = var.clusters[0].name
  project_id                       = var.clusters[0].project_id
  region                           = var.clusters[0].region
  humanitec_crds_already_installed = var.humanitec_crds_already_installed
}

locals {
  clusters = [
    for i in range(length(var.env_types)) : {
      "id" : "${var.clusters[0].name}-${var.env_types[i].id}"
      "env_type" : var.env_types[i].id
      "name" : var.clusters[0].name
      "load_balancer" : module.gcp_cluster.load_balancer
      "region" : var.clusters[0].region
      "project_id" : var.clusters[0].project_id
      "operator_public_key" : i == 0 ? module.gcp_cluster.operator_public_key : ""
      "agent_public_key" : module.gcp_cluster.agent_public_key
    }
  ]
}
module "htc_clusters" {
  for_each = { for cluster in local.clusters : cluster.id => cluster }

  source = "./modules/htc-cluster"

  id                  = each.value.id
  env_type            = each.value.env_type
  region              = each.value.region
  project_id          = each.value.project_id
  name                = each.value.name
  load_balancer       = each.value.load_balancer
  operator_public_key = each.value.operator_public_key
  agent_public_key    = each.value.agent_public_key
}

module "apps" {
  for_each = { for app in var.apps : app.id => app }

  source = "./modules/htc-app"

  app_id       = each.value.id
  app_name     = each.value.name
  env_types    = var.env_types
  viewer_users = each.value.viewer_users

  depends_on = [module.org]
}