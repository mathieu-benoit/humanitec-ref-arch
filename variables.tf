variable "org_id" {
  description = "ID of the Humanitec Organization"
  type        = string
}

variable "env_types" {
  type = list(object({
    id          = string
    description = string
  }))
  default = [
    /*{
      "id" : "development",
      "description" : "Development"
    },*/
    {
      "id" : "staging",
      "description" : "Staging"
    },
    {
      "id" : "production",
      "description" : "Production"
    }
  ]
}

/*variable "clusters" {
  type = list(object({
    env_type_id               = string
    name                      = string
    load_balancer             = string
    load_balancer_hosted_zone = string
    aws_region                = string
    cloud_account = object({
      aws_role    = string
      external_id = string
    })
  }))
}*/

variable "apps" {
  type = list(object({
    id   = string
    name = string
    viewer_users = list(object({
      email = string
    }))
  }))
}