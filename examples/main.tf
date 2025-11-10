provider "aws" {
  region = "us-east-1"
}

# Bucket para armazenar os artefatos da aplicação Lambda
resource "aws_s3_bucket" "artifacts" {
  bucket = "lambda-artifacts-${random_id.id.hex}"
}

resource "random_id" "id" {
  byte_length = 8
}

module "lambda" {
  source = "../"

  function_name = "minha-funcao-lambda-go"
  description   = "Minha função Lambda de exemplo em Go."

  # Aponta para o diretório que contém o código-fonte e o executável `bootstrap`
  source_code_path = "${path.module}/app"
  artifacts_bucket = aws_s3_bucket.artifacts.id

  tags = {
    Environment = "example"
    Language    = "Go"
  }
}
