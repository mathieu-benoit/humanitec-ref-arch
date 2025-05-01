variable "app_id" {
  description = "ID of the Humanitec Application"
  type        = string
}

variable "app_name" {
  description = "Name of the Humanitec Application"
  type        = string
}

variable "clusters" {
  type = list(object({
    cluster_name = string
    env_type_id  = string
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
      "id" : "dev",
      "name" : "Development",
      "type" : "non-prod"
    },
    {
      "id" : "qa",
      "name" : "QA",
      "type" : "non-prod"
    },
    {
      "id" : "uat",
      "name" : "UAT",
      "type" : "non-prod"
    },
    {
      "id" : "prod",
      "name" : "Production",
      "type" : "prod"
    },
    {
      "id" : "dr",
      "name" : "DR",
      "type" : "prod"
    }
  ]
}

variable "viewer_users" {
  type = list(object({
    email = string
  }))
  default = []
}