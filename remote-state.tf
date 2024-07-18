data "terraform_remote_state" "vpc" {
  backend = "s3"
  workspace = terraform.workspace
  config = {
    region         = "us-east-1"
    bucket         = "habi-terraform-bucket"
    key            = "vpc/infrastructure.tfstate"
    dynamodb_table = "terraform_locks"
    role_arn       = "arn:aws:iam::12345678910:role/terraform"
  }
}