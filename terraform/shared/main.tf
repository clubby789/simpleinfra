terraform {
  required_version = ">= 1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.76.0"
    }
    dns = {
      source  = "hashicorp/dns"
      version = "~> 2.2.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
  }

  backend "s3" {
    bucket         = "rust-terraform"
    key            = "simpleinfra/shared.tfstate"
    region         = "us-west-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-west-1"
}

provider "aws" {
  region = "us-east-1"
  alias  = "east1"
}

data "aws_caller_identity" "current" {}
data "aws_canonical_user_id" "current" {}
