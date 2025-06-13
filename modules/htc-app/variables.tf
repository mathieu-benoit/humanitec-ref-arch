variable "app_id" {
  description = "ID of the Humanitec Application"
  type        = string
}

variable "app_name" {
  description = "Name of the Humanitec Application"
  type        = string
}

variable "cost_center" {
  description = "Cost Center ID"
  type        = string
}

variable "gcp_project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "gcp_region" {
  description = "Google Cloud Project region"
  type        = string
}

variable "env_types" {
  type = list(object({
    id          = string
    description = string
  }))
}

variable "envs" {
  type = list(object({
    id   = string
    name = string
    type = string
  }))
  default = [
    {
      "id" : "development",
      "name" : "development",
      "type" : "development"
    },
    {
      "id" : "staging",
      "name" : "staging",
      "type" : "staging"
    },
    {
      "id" : "production",
      "name" : "production",
      "type" : "production"
    }
  ]
}

variable "viewer_users" {
  type = list(object({
    email = string
  }))
  default = []
}

variable "resource_quota" {
  type = object({
    limits-cpu    = string
    limits-memory = string
  })
  default = null
}

variable "cloud_account_gsa_email" {
  description = "Google Cloud Service Account email address to provision cloud infrastructure"
  type        = string
}

variable "cloud_account_id" {
  description = "Google Cloud Service Account ID to provision cloud infrastructure"
  type        = string
}

variable "gcp_wi_pool_provider_name" {
  description = "The Workload Identity Pool Provider name to access the GKE cluster from Humanitec."
  type        = string
}
