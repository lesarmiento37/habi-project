output "kms_key_id" {
  value = aws_kms_key.terraform_key.id
}

output "kms_key_arn" {
  value = aws_kms_key.terraform_key.arn
}

output "secrets_id" {
  value = aws_secretsmanager_secret.terraform.id
}

output "secrets_arn" {
  value = aws_secretsmanager_secret.terraform.arn
}
