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

/*
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
*/
variable "public_path" {
  type = string
  description = "Path for bl cevap public directory"
}

variable "content_version" {
  type        = number
  description = "Content version (positive integer starting from 1)"

    validation {
    condition     = can(regex("^([1-9]\\d*)$", var.content_version))
    error_message = "Content version must be a positive integer starting from 1."
  }
}
