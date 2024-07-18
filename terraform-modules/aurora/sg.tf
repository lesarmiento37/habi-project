resource "aws_security_group" "aurora" {
  name_prefix = "${var.environment}-aurora-sg"
  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
    cidr_blocks = [var.aurora_cidr]
  }
  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    cidr_blocks = ["192.168.3.0/24"]
    self      = "true"
  }

  tags = {
    Environment = "${var.environment}"
  }
  
}