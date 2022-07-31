provider "aws" {
  region  = var.region
  access_key = var.access_key
  secret_key = var.secret_key
  token = var.token
}

data "archive_file" "archive" {
  type        = "zip"
  source_file = "greet_lambda.py"
  output_path = var.output_archive_name
}

resource "aws_iam_role" "lambda_role_exec" {
  name = "lamda_role_poli"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_lambda_function" "greet_lambda" {
  filename      = var.output_archive_name
  function_name = var.function_name
  role          = aws_iam_role.lambda_role_exec.arn
  handler       = var.lambda_handler

  source_code_hash = data.archive_file.archive.output_base64sha256

  runtime = var.function_runtime

  depends_on = [aws_iam_role_policy_attachment.lambda_logs]

  environment {
    variables = {
      greeting = "Greetings From Ahmed Moustafa"
    }
  }
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/aws/lambda/${var.function_name}/"
  description = "IAM policy for logging from a lambda"

  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
})
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_role_exec.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}