data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "../lambda.zip"
  source_dir  = "../lambda"
}

resource "aws_lambda_function" "pwa" {
  function_name = "RequestUnicorn"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "requestUnicorn.handler"

  filename         = "../lambda.zip"
  source_code_hash = filebase64sha256("../lambda.zip")

  runtime = "nodejs10.x"

  environment {
    variables = {
      foo = "bar"
    }
  }
  depends_on = [data.archive_file.lambda_zip]
}