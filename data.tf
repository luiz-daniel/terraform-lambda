data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "archive_file" "source_zip" {
  count = var.source_code_path != null ? 1 : 0

  type        = "zip"
  source_dir  = var.source_code_path
  output_path = "${path.module}/lambda.zip"
}
