resource "aws_iam_role_policy" "inline_policy_deprecated" {
  for_each = { for policy in var.inline_policies : policy.name => policy }

  name = each.value["name"]
  role = aws_iam_role.lambda-role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = each.value.actions
        Resource = each.value.resources
      },
    ]
  })
}

resource "aws_iam_role_policy" "main" {
  for_each = var.policies

  name   = each.key
  role   = aws_iam_role.lambda-role.id
  policy = each.value
}

resource "aws_iam_role" "lambda-role" {
  name               = "${var.function_name}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "managed" {
  for_each = toset([
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess",
  ])

  role       = aws_iam_role.lambda-role.name
  policy_arn = each.value
}
