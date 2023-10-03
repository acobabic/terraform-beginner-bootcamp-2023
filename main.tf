terraform {
  cloud {
    organization = "BBA-LEARN"

    workspaces {
      name = "terra-house-1"
    }
  }

  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}

provider "terratowns" {
  endpoint = "http://localhost:4567/api"
  user_uuid = "e328f4ab-b99f-421c-84c9-4ccea042c7d1"
  token = "9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}

/*
module "terrahouse_aws" {
  source               = "./modules/terrahouse_aws"
  user_uuid            = var.user_uuid
  bucket_name          = var.bucket_name
  environment          = var.environment
  index_html_file_path = var.index_html_file_path
  error_html_file_path = var.error_html_file_path
  content_version      = var.content_version
  assets_path = var.assets_path
}
*/

resource "terratowns_home" "half_life" {
  name = "Half Life"
  description = <<DESCRIPTION
I love Half Life game. It is my first PC game ever and I consider it as my first gamers love :D
DESCRIPTION
  #domain_name = module.terrahouse_aws.s3_distribution_domain_name
  domain_name = "3xf332sdfs.cloudfront.net"
  town = "gamers-grotto"
  content_version = 1
}