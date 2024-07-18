resource "aws_db_subnet_group" "aurora" {
  name        = "${var.cluster_name}-subnet-group-habi-${var.environment}"
  subnet_ids  = var.db_subnets
  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}