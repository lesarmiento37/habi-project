variable "environment" {
  description = "Deployment Environment"
}

variable "cluster_name" {
  description = "Cluster Identifier"
}

variable "database_name" {
  description = "Database Name"
}

variable "database_password" {
  description = "Database Password"
}

variable "database_username" {
  description = "Database Username"
}

variable "db_subnets" {
  description = "DB subnets group"
}

variable "proxy_subnets" {
  description = "Proxy subnets group"
}

variable "db_secrets"{
  description = "DB secrets"
}

variable "sg"{
  description = "The Sg of the aurora cluster"
}

variable "iam_policies"{
  description = "The iam lambda"
}

variable "instance_count"{
  description = "Instance count"
}

variable "instance_size"{
  description = "Instance size"
}

variable "aurora_interval"{
  description = "Aurora interval"
}

variable "account_id"{
  description = "Account id"
}
variable aurora_cidr {
  type        = string
  description = "The vpc cidr"
}
variable public_access {
  description = "Public Access"
}

