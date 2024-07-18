resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "${var.cluster_name}-${var.environment}-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = "75"
  alarm_description   = "CPU utilization exceeds 75% for 3 consecutive periods"
  alarm_actions       = [aws_sns_topic.aurora.arn]  

  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.aurora.id
  }
}
resource "aws_cloudwatch_metric_alarm" "connections_alarm" {
  alarm_name          = "${var.cluster_name}-${var.environment}-connections-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "DatabaseConnections"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = "500"
  alarm_description   = "Database connections exceed 500 for 3 consecutive periods"
  alarm_actions       = [aws_sns_topic.aurora.arn] 

  dimensions = {
    DBClusterIdentifier = aws_rds_cluster.aurora.id
  }
}
