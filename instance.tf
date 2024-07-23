resource "aws_rds_cluster_instance" "cluster_instances" {
  count               = var.instance_count
  identifier          = "${var.cluster_name}-habi-instance-${var.environment}-${count.index}"
  cluster_identifier  = "${var.cluster_name}-${var.environment}"
  instance_class      = var.instance_size
  engine              = "aurora-mysql"
  publicly_accessible = var.public_access
  performance_insights_enabled  = true
  performance_insights_retention_period = 7
  monitoring_interval = var.aurora_interval
  depends_on = [aws_rds_cluster.aurora]
   lifecycle {
    prevent_destroy = false
  }
}
