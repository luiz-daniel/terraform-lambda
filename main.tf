resource "aws_lambda_function" "lambda" {
  function_name = var.function_name
  filename      = var.filename
  role          = aws_iam_role.lambda-role.arn
  handler       = var.handler
  runtime       = var.runtime
  timeout       = var.timeout
  memory_size   = var.memory
  architectures = var.architectures
  source_code_hash = filebase64sha512(var.filename)

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
  count = var.api ? 1 : 0
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"
}

resource "aws_lambda_alias" "alias" {
  name             = "latest"
  function_name    = aws_lambda_function.lambda.function_name
  function_version = aws_lambda_function.lambda.version
}