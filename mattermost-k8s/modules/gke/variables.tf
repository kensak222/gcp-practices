variable "region" {
  description = "GCP Region"
}

variable "project_id" {
  description = "GCP project ID"
}

variable "sql_user_password" {
  description = "The password for the PostgreSQL database user."
  type        = string
}
