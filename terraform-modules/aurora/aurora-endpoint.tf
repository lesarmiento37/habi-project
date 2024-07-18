resource "aws_rds_cluster_endpoint" "aurora" {
  cluster_identifier = aws_rds_cluster.aurora.id
  cluster_endpoint_identifier = "${var.cluster_name}-${var.environment}-endpoint"
  custom_endpoint_type        = "ANY"
}
