resource "aws_sqs_queue" "terraform_queue" {
  name                        = "${var.queue_name}"
  fifo_queue                  = false
  tags = {
    Environment = var.environment
    Terraform   = true
  }
}

resource "aws_sqs_queue" "terraform_queue_deadletter" {
  name = "deadletter-${var.queue_name}"
  fifo_queue = false
  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.terraform_queue.arn]
  })
  tags = {
    Environment = var.environment
    Terraform   = true
  }
}

