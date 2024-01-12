terraform {
  backend "s3" {
    region = var.region
    bucket = "github-techmoney-terraform"
    key    = "${var.function_name}/terraform.tfstate"
  }
}