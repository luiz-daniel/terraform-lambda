terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    region = var.region
    key    = "terraform/${var.function_name}/terraform.tfstate"
  }
}

provider "aws" {
  region = var.region
}