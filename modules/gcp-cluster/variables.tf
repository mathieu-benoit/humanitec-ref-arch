variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  description = "GCP Region"
}

variable "cluster_name" {
  description = "GKE cluster name"
  type        = string
}

variable "org_id" {
  type        = string
  description = "Humanitec Organization ID"
}

# Custom resource definitions must be applied before custom resources. 
# This is because the provider queries the Kubernetes API for the OpenAPI specification for the resource supplied in the manifest attribute.
# If the CRD doesn’t exist in the OpenAPI specification during plan time then Terraform can’t use it to create custom resources.
variable "humanitec_crds_already_installed" {
  description = "Custom resource definitions must be applied before custom resources."
  type        = bool
  default     = false
}