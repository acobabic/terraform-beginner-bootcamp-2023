variable "user_uuid" {
  type = string
}

variable "environment" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "index_html_file_path" {
  type = string
}

variable "error_html_file_path" {
  type = string
}

variable "content_version" {
  type        = number
  description = "Content version (positive integer starting from 1)"
}
