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

variable "network_id" {
  description = "The ID of the VPC network"
  type        = string
}

variable "mattermost_subnet_id" {
  description = "The ID of the Mattermost Subnet"
  type        = string
}
