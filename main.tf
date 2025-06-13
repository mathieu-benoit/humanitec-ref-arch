module "org" {
  source = "./modules/htc-org"

  org_id    = var.org_id
  token     = var.token
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

module "htc_cluster" {
  source = "./modules/htc-cluster"

  id                        = module.gcp_cluster.cloud_account_id
  env_types                 = var.env_types
  region                    = var.clusters[0].region
  project_id                = var.clusters[0].project_id
  project_number            = module.gcp_cluster.project_number
  name                      = var.clusters[0].name
  load_balancer             = module.gcp_cluster.load_balancer
  operator_public_key       = module.gcp_cluster.operator_public_key
  agent_public_key          = module.gcp_cluster.agent_public_key
  cluster_access_gsa_email  = module.gcp_cluster.cluster_access_gsa_email
  gcp_wi_pool_provider_name = module.gcp_cluster.gcp_wi_pool_provider_name
}

module "gcp_app" {
  source = "./modules/gcp-app"

  org_id           = var.org_id
  app_id           = var.apps[1].id
  gcp_project_id   = var.apps[1].gcp_project_id
  gcp_wi_pool_name = module.gcp_cluster.gcp_wi_pool_name
}

module "apps" {
  for_each = { for app in var.apps : app.id => app }

  source = "./modules/htc-app"

  app_id                    = each.value.id
  app_name                  = each.value.name
  cost_center               = each.value.cost_center
  gcp_project_id            = each.value.gcp_project_id
  env_types                 = var.env_types
  viewer_users              = each.value.viewer_users
  resource_quota            = each.value.resource_quota
  cloud_account_gsa_email   = module.gcp_app.cloud_account_gsa_email
  cloud_account_id          = module.gcp_app.cloud_account_id
  gcp_wi_pool_provider_name = module.gcp_cluster.gcp_wi_pool_provider_name

  depends_on = [module.org]
}