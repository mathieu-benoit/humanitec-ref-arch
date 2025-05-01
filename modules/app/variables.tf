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
    env_type     = string
  }))
  default = []
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