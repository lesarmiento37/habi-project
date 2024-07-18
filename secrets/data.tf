data "sops_file" "secrets" {
  source_file = local.source_file[terraform.workspace]
}