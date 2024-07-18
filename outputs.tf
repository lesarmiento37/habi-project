output "cluster_endpoint" {
  value = aws_rds_cluster.aurora.endpoint
}

output "sqs_arn" {
  value = aws_sqs_queue.terraform_queue.arn
}
output "sqs_dead_letter_arn" {
  value = aws_sqs_queue.terraform_queue_deadletter.arn
}