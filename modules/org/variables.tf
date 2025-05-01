variable "env_types" {
  type = list(object({
    id          = string
    description = string
  }))
}