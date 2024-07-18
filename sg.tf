resource "aws_security_group" "aurora" {
  name_prefix = "${var.environment}-aurora-sg"
  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    cidr_blocks = [var.aurora_cidr]
  }
  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self      = "true"
  }

  tags = {
    Environment = "${var.environment}"
  }
  
}