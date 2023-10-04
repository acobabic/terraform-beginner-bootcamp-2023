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

variable "bucket_name" {
  type        = string
  description = "The name of the AWS S3 bucket"
}

variable "index_html_file_path" {
  type        = string
  description = "Full path to our Static Website index.html page"
}

variable "error_html_file_path" {
  type        = string
  description = "Full path to our Static Website error.html page"
}

variable "assets_path" {
  type        = string
  description = "Full path to our assets folder"
}

variable "content_version" {
  type        = number
  description = "Content version (positive integer starting from 1)"
}
