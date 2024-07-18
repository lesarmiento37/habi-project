data "aws_secretsmanager_secret_version" "my_secret" {
  secret_id =local.secrets_value[terraform.workspace]
}

