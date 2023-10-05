## Terrahome AWS

```tf
module "home_bl_cevap" {
  source               = "./modules/terrahome_aws"
  user_uuid            = var.user_uuid
  environment          = var.environment
  public_path = var.bl_cevap.public_path
  content_version      = var.content_version
  assets_path          = var.assets_path
```

It is important to note taht the public directory expects the following:
- index.html
- error.html
- assets

All top level files in assets will be copied, but not any subdirectories.