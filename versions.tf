#---------------------------------------------------------------------------
# VERSIONS
#---------------------------------------------------------------------------
terraform {
  required_providers {
    acme = {
      source  = "vancluever/acme"
      version = "~> 2.0.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.25.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2.0"
    }
    tls = {
      source = "hashicorp/tls"
    }
  }
  required_version = ">= 0.13"
}

provider "aws" {
  region = var.region
}