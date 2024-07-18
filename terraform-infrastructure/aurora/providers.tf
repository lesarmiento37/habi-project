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

