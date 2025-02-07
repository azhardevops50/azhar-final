/*terraform {
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
    bucket = "ocr-terraform-state-bucket"
    key    = "test/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = "true"
  }
}

provider "aws" {
  region = var.region
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
*/

data "aws_ssm_parameter" "my_env_var" {
  name = "MY_ENV_VAR"
}

data "aws_ssm_parameter" "new_env_var" {
  name = "NEW_ENV_VAR"
}

resource "kubernetes_secret" "my_app_secrets" {
  metadata {
    name      = "my-app-secrets"
    namespace = "ocr"
  }

  data = {
    MY_ENV_VAR  = data.aws_ssm_parameter.my_env_var.value
    NEW_ENV_VAR = data.aws_ssm_parameter.new_env_var.value
  }
}