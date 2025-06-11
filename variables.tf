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
  default = [
    {
      "id" : "development",
      "description" : "Development"
    },
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

variable "clusters" {
  type = list(object({
    project_id = string
    name       = string
    region     = string
  }))
}

variable "apps" {
  type = list(object({
    id             = string
    name           = string
    cost_center    = string
    gcp_project_id = string
    viewer_users = list(object({
      email = string
    }))
    resource_quota = object({
      limits-cpu    = string
      limits-memory = string
    })
  }))
}

# Custom resource definitions must be applied before custom resources. 
# This is because the provider queries the Kubernetes API for the OpenAPI specification for the resource supplied in the manifest attribute.
# If the CRD doesn’t exist in the OpenAPI specification during plan time then Terraform can’t use it to create custom resources.
variable "humanitec_crds_already_installed" {
  description = "Custom resource definitions must be applied before custom resources."
  type        = bool
  default     = false
}