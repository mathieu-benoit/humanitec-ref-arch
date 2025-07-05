terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.1"
    }
    helm = {
      source = "hashicorp/helm"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    tls = {
      source = "hashicorp/tls"
    }
    humanitec = {
      source  = "humanitec/humanitec"
      version = "~> 1.0"
    }
    terracurl = {
      source = "devops-rob/terracurl"
    }
  }
  required_version = ">= 1.3.0"
}

provider "humanitec" {
  org_id = var.org_id
  token  = var.token
}