
resource "aws_lambda_function" "lambda_write_sqs" {
  filename         = "lambda_write_sqs.zip"
  function_name    = "lambda_write_sqs"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "lambda_write_sqs.lambda_handler"
  runtime          = "python3.10"
  source_code_hash = filebase64sha256("lambda_write_sqs.zip")

  environment {
    variables = {
      QUEUE_URL = aws_sqs_queue.terraform_queue.id
    }
  }
}

resource "aws_lambda_function" "lambda_write_rds" {
  filename         = "lambda_write_rds.zip"
  function_name    = "lambda_write_rds"
  role             = aws_iam_role.lambda_exec_rds.arn
  handler          = "lambda_write_rds.lambda_handler"
  runtime          = "python3.10"
  source_code_hash = filebase64sha256("lambda_write_rds.zip")

  environment {
    variables = {
      DB_HOST     = aws_rds_cluster.aurora.endpoint
      DB_USER     = replace(jsonencode(local.my_secret_object.username), "\"", "")
      DB_PASSWORD = replace(jsonencode(local.my_secret_object.password), "\"", "")
      DB_NAME     = replace(jsonencode(local.my_secret_object.dbname), "\"", "")
    }
  }
    vpc_config {
    subnet_ids         = [data.terraform_remote_state.vpc.outputs.private_subnets]
    security_group_ids = [data.terraform_remote_state.vpc.outputs.sg]
  }
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_write_sqs.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.daily_trigger.arn
}

resource "aws_cloudwatch_event_rule" "daily_trigger" {
  name                = "daily_trigger"
  schedule_expression = "rate(1 day)"
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.daily_trigger.name
  target_id = "lambda_write_sqs"
  arn       = aws_lambda_function.lambda_write_sqs.arn
}

resource "aws_lambda_event_source_mapping" "sqs_to_lambda" {
  event_source_arn = aws_sqs_queue.queue.arn
  function_name    = aws_lambda_function.lambda_write_rds.arn
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

data "aws_iam_policy_document" "lambda_policy_lambda_sqs_sm" {
  statement {
    actions = [
      "secretsmanager:GetSecretValue",
      "sqs:SendMessage",
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "lambda_policy_lambda_sqs_sm" {
  name   = "lambda_policy"
  policy = data.aws_iam_policy_document.lambda_policy_lambda_sqs_sm.json
}

resource "aws_iam_role_policy_attachment" "lambda_sm_sqs_execution" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_policy_lambda_sqs_sm
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_sqs_execution" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaSQSQueueExecutionRole"
}


resource "aws_iam_role" "lambda_exec_rds" {
  name = "lambda_exec_role_rds"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_rds_execution" {
  role       = aws_iam_role.lambda_exec_rds.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution_rds" {
  role       = aws_iam_role.lambda_exec_rds.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}