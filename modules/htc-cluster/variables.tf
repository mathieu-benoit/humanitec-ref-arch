variable "id" {
  type        = string
  description = "ID of the GKE cluster resource"
}

variable "env_type" {
  type        = string
  description = "Humanitec Environment Type"
}

variable "project_id" {
  type        = string
  description = "GCP Project ID"
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