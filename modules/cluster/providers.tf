terraform {
  required_providers {
    humanitec = {
      source  = "humanitec/humanitec"
      version = "~> 1.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.3.0"
}