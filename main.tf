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


module "home_half_life_hosting" {
  source               = "./modules/terrahome_aws"
  user_uuid            = var.user_uuid
  environment          = var.environment
  public_path = var.half_life.public_path
  content_version      = var.half_life.content_version
}

resource "terratowns_home" "home_half_life" {
  name            = "Half Life"
  description     = <<DESCRIPTION
I love Half Life game. It is my first PC game ever and I consider it as my first gamers love :D
DESCRIPTION
  domain_name     = module.home_half_life_hosting.s3_distribution_domain_name
  town            = "missingo"
  content_version = 1
}

/*
module "home_bl_cevap_hosting" {
  source               = "./modules/terrahome_aws"
  user_uuid            = var.user_uuid
  environment          = var.environment
  public_path = var.bl_cevap.public_path
  content_version      = var.bl_cevap.content_version
}

resource "terratowns_home" "home_bl_cevap" {
  name            = "This is a traditional dish in the city of Banja Luka"
  description     = <<DESCRIPTION
Banjalucki cevap refers to a regional variation of the popular Balkan dish known as "ćevapi" or "ćevapčići.
Ćevapi are small, grilled minced meat sausages typically made from a mixture of ground beef and sometimes mixed with lamb or pork.
They are seasoned with various herbs and spices, such as garlic, paprika, and onion, giving them a flavorful and savory taste.
DESCRIPTION
  domain_name     = module.home_bl_cevap_hosting.s3_distribution_domain_name
  town            = "missingo"
  content_version = 1
}
*/