variable "user_uuid" {
  type        = string
  description = "User UUID tag to associate with resources"
}

variable "environment" {
  type        = string
  description = "Environment for the resource"
}

variable "bucket_name" {
  type        = string
  description = "The name of the AWS S3 bucket"
}

