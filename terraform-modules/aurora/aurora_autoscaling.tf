resource "aws_appautoscaling_target" "aurora_target" {
  max_capacity       = 10  
  min_capacity       = var.instance_count - 1
  resource_id        = "cluster:${aws_rds_cluster.aurora.id}"
  scalable_dimension = "rds:cluster:ReadReplicaCount"
  service_namespace  = "rds"
}
resource "aws_appautoscaling_policy" "aurora_policy" {
  name               = "${var.cluster_name}-${var.environment}-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.aurora_target.resource_id
  scalable_dimension = aws_appautoscaling_target.aurora_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.aurora_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "RDSReaderAverageCPUUtilization"
    }
    scale_in_cooldown  = 60  
    scale_out_cooldown = 60  
    target_value       = 80 
  }
}
