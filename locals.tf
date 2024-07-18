locals {
  my_secret_object = jsondecode(data.aws_secretsmanager_secret_version.my_secret.secret_string)
  secrets_value = {
    production = "db-secrets"
  }
  iam_aurora = {
    production = "arn:aws:iam::12345678910:policy/aurora-policy"
  }
  secrets_dbs = {
    production = "arn:aws:secretsmanager:us-east-1:12345678910:secret:db-secrets-Leo123"
  }
  aurora_count = {
    production = 3
  }
  aurora_size = {
    production = "db.r5.large"
  }
  aurora_monitoring = {
    production = 0
  }
  account_id = {
    production = "12345678910"
  }
  aurora_range = {
    production = "192.168.3.0/24"
  }
  public_access = {
    production = false
  }
}