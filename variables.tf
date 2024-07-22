variable "environment" {
  description = "Environment"
  default     = "production"
}

variable "cluster_name" {
  description = "Cluster name"
  default     = "habi-cluster"
}

variable "db_subnets" {
  description = "Database subnets"
  default     = data.terraform_remote_state.vpc.outputs.private_subnets
}

variable "database_name" {
  description = "Database name"
  default     = replace(jsonencode(local.my_secret_object.dbname), "\"", "")
}

variable "database_password" {
  description = "Database password"
  default     = replace(jsonencode(local.my_secret_object.password), "\"", "")
}

variable "database_username" {
  description = "Database username"
  default     = replace(jsonencode(local.my_secret_object.username), "\"", "")
}

variable "db_secrets" {
  description = "Database secrets"
  default     = local.secrets_dbs[terraform.workspace]
}

variable "sg" {
  description = "Security groups"
  default     = data.terraform_remote_state.vpc.outputs.sg
}

variable "proxy_subnets" {
  description = "Proxy subnets"
  default     = data.terraform_remote_state.vpc.outputs.public_subnets
}

variable "aurora_cidr" {
  description = "Aurora CIDR"
  default     = data.terraform_remote_state.vpc.outputs.vpc_cidr
}

variable "iam_policies" {
  description = "IAM policies"
  default     = local.iam_aurora[terraform.workspace]
}

variable "instance_count" {
  description = "Instance count"
  default     = local.aurora_count[terraform.workspace]
}

variable "instance_size" {
  description = "Instance size"
  default     = local.aurora_size[terraform.workspace]
}

variable "aurora_interval" {
  description = "Aurora monitoring interval"
  default     = local.aurora_monitoring[terraform.workspace]
}

variable "account_id" {
  description = "Account ID"
  default     = local.account_id[terraform.workspace]
}

variable "public_access" {
  description = "Public access"
  default     = true
}

variable "queue_name" {
  description = "Queue name"
  default     = "habi-queue"
}
