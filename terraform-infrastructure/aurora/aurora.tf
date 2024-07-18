module "aurora" {
  source = "git@github.com:lesarmiento37/habi-project.git//terraform-modules//aurora"
  environment = terraform.workspace
  cluster_name = "habi-cluster"
  db_subnets = data.terraform_remote_state.vpc.outputs.private_subnets
  database_name = replace(jsonencode(local.my_secret_object.dbname), "\"", "")
  database_password = replace(jsonencode(local.my_secret_object.password), "\"", "")
  database_username = replace(jsonencode(local.my_secret_object.username), "\"", "")
  db_secrets = local.secrets_dbs[terraform.workspace]
  sg = data.terraform_remote_state.vpc.outputs.sg
  proxy_subnets = data.terraform_remote_state.vpc.outputs.public_subnets
  aurora_cidr = data.terraform_remote_state.vpc.outputs.vpc_cidr
  iam_policies = local.iam_aurora[terraform.workspace]
  instance_count = local.aurora_count[terraform.workspace]
  instance_size = local.aurora_size[terraform.workspace]
  aurora_interval = local.aurora_monitoring[terraform.workspace]
  account_id = local.account_id[terraform.workspace]
}