terraform {
  cloud {
    organization = "BBA-LEARN"

    workspaces {
      name = "terra-house-1"
    }
  }

  required_providers {
    terratowns = {
      source  = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}

provider "terratowns" {
  endpoint  = var.terratowns_endpoint
  user_uuid = var.user_uuid
  token     = var.user_terratowns_token
}


module "terrahouse_aws" {
  source               = "./modules/terrahouse_aws"
  user_uuid            = var.user_uuid
  environment          = var.environment
  index_html_file_path = var.index_html_file_path
  error_html_file_path = var.error_html_file_path
  content_version      = var.content_version
  assets_path          = var.assets_path
}

resource "terratowns_home" "half_life" {
  name            = "Half Life"
  description     = <<DESCRIPTION
I love Half Life game. It is my first PC game ever and I consider it as my first gamers love :D
DESCRIPTION
  domain_name     = module.terrahouse_aws.s3_distribution_domain_name
  town            = "missingo"
  content_version = 1
}