locals {
  is_s3_deployment   = var.source_code_path != null
  effective_filename = coalesce(var.filename, "lambda.zip")

  lambda_function = local.is_s3_deployment ? aws_lambda_function.from_s3[0] : aws_lambda_function.from_file[0]
}

resource "aws_lambda_function" "from_file" {
  count = !local.is_s3_deployment ? 1 : 0

  function_name    = var.function_name
  description      = var.description
  role             = aws_iam_role.lambda-role.arn
  handler          = var.handler
  runtime          = var.runtime
  timeout          = var.timeout
  memory_size      = var.memory
  architectures    = var.architectures
  tags             = var.tags
  publish          = true
  filename         = local.effective_filename
  source_code_hash = filemd5(local.effective_filename)

  environment {
    variables = var.environment
  }

  tracing_config {
    mode = "Active"
  }

  ephemeral_storage {
    size = var.ephemeral_storage
  }
}

resource "aws_lambda_function" "from_s3" {
  count = local.is_s3_deployment ? 1 : 0

  function_name = var.function_name
  description   = var.description
  role          = aws_iam_role.lambda-role.arn
  handler       = var.handler
  runtime       = var.runtime
  timeout       = var.timeout
  memory_size   = var.memory
  architectures = var.architectures
  tags          = var.tags
  publish       = true
  s3_bucket     = var.artifacts_bucket
  s3_key        = aws_s3_object.lambda_source[0].key

  environment {
    variables = var.environment
  }

  tracing_config {
    mode = "Active"
  }

  ephemeral_storage {
    size = var.ephemeral_storage
  }
}

resource "aws_lambda_permission" "gateway-permission" {
  count         = var.api ? 1 : 0
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = local.lambda_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = var.api_gateway_source_arn != "" ? var.api_gateway_source_arn : null
}

resource "aws_lambda_alias" "alias" {
  name             = var.alias_name
  function_name    = local.lambda_function.function_name
  function_version = local.lambda_function.version
}
