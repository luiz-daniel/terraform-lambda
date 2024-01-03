data "aws_iam_policy_document" "lambda_crud_policy" {
  statement {
    sid     = "1"
    actions = [
      "logs:*",
      "rds:DescribeDBClusters",
      "rds:DescribeDBClusterParameters",
      "rds:DescribeDBSubnetGroups",
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeVpcs",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "kms:Decrypt",
      "secretsmanager:GetSecretValue",
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords",
      "dynamodb:PutItem",
      "dynamodb:GetItem",
      "dynamodb:DeleteItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:UpdateItem",
      "cognito-idp:AdminConfirmSignUp",
      "execute-api:*",
      "sqs:*"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

  }
}