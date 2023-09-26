terraform {
  cloud {
    organization = "BBA-LEARN"

    workspaces {
      name = "terra-house-1"
    }
  }
}

module "terrahouse_aws" {
  source      = "./modules/terrahouse_aws"
  user_uuid   = var.user_uuid
  bucket_name = var.bucket_name
  environment = var.environment
}