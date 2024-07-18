resource "aws_db_proxy" "aurora" {
  name               = "${var.cluster_name}-proxy-habytat-${var.environment}"
  role_arn           = aws_iam_role.aurora.arn
  #db_proxy_target_id = aws_rds_cluster.aurora.id
  engine_family      = "POSTGRESQL"
  debug_logging      = true
  vpc_subnet_ids     = var.proxy_subnets
  vpc_security_group_ids  = [var.sg]
  require_tls = false

  auth {
    auth_scheme = "SECRETS"
    description = "Secrets for connect serverless to aurora DB"
    secret_arn  = var.db_secrets
    iam_auth    = "DISABLED"
  }
  idle_client_timeout    = 1800
  
  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
  depends_on = [aws_rds_cluster.aurora]
}

resource "aws_db_proxy_default_target_group" "aurora" {
  db_proxy_name = aws_db_proxy.aurora.name

  connection_pool_config {
    connection_borrow_timeout    = 120
    #init_query                   = "SET x=1, y=2"
    max_connections_percent      = 100
    max_idle_connections_percent = 50
    #session_pinning_filters      = ["EXCLUDE_VARIABLE_SETS"]
  }
}

resource "aws_db_proxy_target" "aurora" {
  db_cluster_identifier  = aws_rds_cluster.aurora.id
  db_proxy_name          = aws_db_proxy.aurora.name
  target_group_name      = aws_db_proxy_default_target_group.aurora.name
  depends_on             = [aws_db_proxy.aurora]
}