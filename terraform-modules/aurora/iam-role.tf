resource "aws_iam_role" "aurora" {
  name = "${var.cluster_name}-role-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "rds.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

resource "aws_iam_policy_attachment" "aurora" {
  name = "${var.cluster_name}-policy"
  policy_arn  = var.iam_policies
  roles       = [aws_iam_role.aurora.name]
}