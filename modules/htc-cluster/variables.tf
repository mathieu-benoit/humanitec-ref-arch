variable "id" {
  type        = string
  description = "ID of the GKE cluster resource"
}

variable "env_types" {
  type = list(object({
    id          = string
    description = string
  }))
}

variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "project_number" {
  type        = string
  description = "GCP Project number"
}

variable "region" {
  type        = string
  description = "GCP Region"
}

variable "name" {
  description = "GKE cluster name"
  type        = string
}

variable "load_balancer" {
  description = "The Load Balancer of the EKS cluster"
  type        = string
}

variable "agent_public_key" {
  description = "The public key of the Agent."
  type        = string
  sensitive   = true
}

variable "operator_public_key" {
  description = "The public key of the Operator."
  type        = string
  sensitive   = true
}

variable "cluster_access_gsa_email" {
  description = "The email of the GSA to access the GKE cluster from Humanitec."
  type        = string
  sensitive   = true
}

variable "gcp_wi_pool_provider_name" {
  description = "The Workload Identity Pool Provider name to access the GKE cluster from Humanitec."
  type        = string
  sensitive   = true
}