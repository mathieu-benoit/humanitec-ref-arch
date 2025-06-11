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