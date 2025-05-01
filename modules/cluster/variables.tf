variable "name" {
  description = "The Name of the EKS cluster"
  type        = string
}

variable "aws_region" {
  description = "The AWS region"
  type        = string
}

variable "env_type_id" {
  description = "The Env Type ID for the EKS cluster"
  type        = string
}

variable "load_balancer" {
  description = "The Load Balancer of the EKS cluster"
  type        = string
}

variable "load_balancer_hosted_zone" {
  description = "The Load Balancer Hosted Zone of the EKS cluster"
  type        = string
}

variable "cloud_account" {
  description = "The AWS Account associated to the EKS cluster and provisioning any infrastructure via Terraform too"
  type = object({
    aws_role    = string
    external_id = string
  })
}