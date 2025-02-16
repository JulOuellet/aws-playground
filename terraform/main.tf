resource "aws_s3_bucket" "test_bucket" {
  bucket = "my-test-bucket"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "s3_write_policy" {
  name = "S3WritePolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["s3:PutObject"]
      Resource = "arn:aws:s3:::my-test-bucket/*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_s3_attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.s3_write_policy.arn
}

resource "aws_lambda_function" "fetch_api_data" {
  function_name    = "hello-lambda"
  role            = aws_iam_role.lambda_role.arn
  handler         = "main.java.com.example.HelloLambda::handleRequest"
  runtime         = "java21"
  filename        = "../target/aws-playground-1.0.jar"
  source_code_hash = filebase64sha256("../target/aws-playground-1.0.jar")

  environment {
    variables = {
      S3_BUCKET = aws_s3_bucket.test_bucket.bucket
    }
  }
}
