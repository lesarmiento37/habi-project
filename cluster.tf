resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = "${var.cluster_name}-${var.environment}"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.03.2"
  database_name           = var.database_name
  master_username         = var.database_username
  master_password         = var.database_password
  db_subnet_group_name    = aws_db_subnet_group.aurora.name
  vpc_security_group_ids  = [var.sg]
  backup_retention_period = 7
  skip_final_snapshot     = true
  preferred_backup_window = "00:00-02:00"
  enabled_cloudwatch_logs_exports = ["general","error","audit"]

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

