variable "org_id" {
  description = "ID of the Humanitec Organization"
  type        = string
}

variable "env_types" {
  type = list(object({
    id          = string
    description = string
  }))
}