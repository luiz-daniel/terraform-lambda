terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    region = "sa-east-1"
    key    = "terraform.tfstate"
  }
}