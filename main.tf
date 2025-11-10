resource "aws_lambda_function" "lambda" {
  function_name = var.function_name
  description   = var.description
  role          = aws_iam_role.lambda-role.arn
  handler       = var.handler
  runtime       = var.runtime
  timeout       = var.timeout
  memory_size   = var.memory

  filename      = var.source_code_path == null ? var.filename : null
  s3_bucket     = var.source_code_path != null ? var.artifacts_bucket : null
  s3_key        = var.source_code_path != null ? aws_s3_object.lambda_source[0].key : null
  source_code_hash = var.source_code_path == null && var.filename != null ? filemd5(var.filename) : null

  ephemeral_storage {
    size = var.ephemeral_storage
  }
  architectures    = var.architectures

  environment {
    variables = var.environment
  }

  tracing_config {
    mode = "Active"
  }

  tags = var.tags

  publish = true
}

resource "aws_lambda_permission" "gateway-permission" {
  count         = var.api ? 1 : 0
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = var.api_gateway_source_arn != "" ? var.api_gateway_source_arn : null
}

resource "aws_lambda_alias" "alias" {
  name             = var.alias_name
  function_name    = aws_lambda_function.lambda.function_name
  function_version = aws_lambda_function.lambda.version
}
