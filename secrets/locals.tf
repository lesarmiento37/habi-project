locals {
  secrets = data.sops_file.secrets.data
  source_file = {
    production = "secrets.production.enc.yaml"
  }
}
