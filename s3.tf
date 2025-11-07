resource "aws_s3_object" "lambda_source" {
  count = var.source_code_path != null ? 1 : 0

  bucket = var.artifacts_bucket
  key    = "${var.function_name}/${data.archive_file.source_zip[0].output_md5}.zip"
  source = data.archive_file.source_zip[0].output_path
}
