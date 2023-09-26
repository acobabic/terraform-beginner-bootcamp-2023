variable "user_uuid" {
  type    = string
  description = "User UUID tag to associate with resources"
  validation {
    condition = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "Invalid user UUID tag format. It should be a valid UUID."
  }
}

variable "environment" {
  type        = string
  description = "Environment for the resource"
  validation {
    condition     = length(var.environment) > 0
    error_message = "Environment must not be an empty string."
  }
}

variable "bucket_name" {
  type        = string
  description = "The name of the AWS S3 bucket"

  validation {
    condition     = can(regex("^[a-zA-Z0-9.-]+$", var.bucket_name))
    error_message = "Invalid S3 bucket name. It must only contain alphanumeric characters, hyphens, and periods."
  }
}

