provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    sops = {
      source = "carlpett/sops"
    }
  }
}

provider "sops" {
}

resource "aws_kms_key" "terraform_key" {
  description = "Terraform KMS key"
  deletion_window_in_days = 7
}

resource "aws_kms_alias" "terraform_alias" {
  name          = "alias/habytat-secrets-manager-kms-${terraform.workspace}"
  target_key_id = aws_kms_key.terraform_key.key_id
}

resource "aws_secretsmanager_secret" "terraform" {
  name = "habytat-secrets-${terraform.workspace}"
}

resource "aws_secretsmanager_secret_version" "terraform_secrets" {
  secret_id = aws_secretsmanager_secret.terraform.id
  secret_string = jsonencode(local.secrets)
}
resource "aws_ssm_parameter" "secrets_version" {
  name  = "/${terraform.workspace}_SECRETS_VERSION"
  type  = "String"
  value = aws_secretsmanager_secret.terraform.arn
}