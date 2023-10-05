variable "user_uuid" {
  type        = string
  description = "User UUID tag to associate with resources"
}

variable "user_terratowns_token" {
  type        = string
  description = "User token for terratown access"
}

variable "terratowns_endpoint" {
  type        = string
  description = "API endpoint of TerraTowns"
}

variable "environment" {
  type        = string
  description = "Environment for the resource"
}

variable "half_life" {
  type = object({
  public_path = string
  content_version = number
})
}

variable "bl_cevap" {
  type = object({
  public_path = string
  content_version = number
})
}