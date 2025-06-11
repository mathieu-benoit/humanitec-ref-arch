variable "org_id" {
  description = "ID of the Humanitec Organization"
  type        = string
}

variable "token" {
  description = "Token to authenticate to Humanitec (just use for terracurl_request for custom resource types)"
  type        = string
  sensitive   = true
}

variable "env_types" {
  type = list(object({
    id          = string
    description = string
  }))
}