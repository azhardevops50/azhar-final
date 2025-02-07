terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.82.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.35.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }
  }
  backend "s3" {
    bucket       = "ocr-terraform-state-bucket"
    key          = "test/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = "true"
  }
}

provider "aws" {
  region = var.region
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}