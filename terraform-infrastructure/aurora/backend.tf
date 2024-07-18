terraform {
  backend "s3" {
    bucket         = "habi-terraform-bucket"
    key            = "aurora/infrastructure.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
    role_arn       = "arn:aws:iam::12345678910:role/terraform"
  }
}