variable "org_id" {
  description = "ID of the Humanitec Organization"
  type        = string
}

variable "app_id" {
  description = "ID of the Humanitec Application"
  type        = string
}

variable "gcp_project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "gcp_wi_pool_name" {
  description = "The Workload Identity Pool name to access the GCP Project from Humanitec."
  type        = string
}