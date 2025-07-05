variable "org_id" {
  description = "ID of the Humanitec Organization"
  type        = string
}

variable "token" {
  description = "Token to provision objects in Humanitec Organization"
  type        = string
  sensitive   = true
}

variable "env_types" {
  type = list(object({
    id          = string
    description = string
  }))
}