variable "project_id" {
  description = "GCP Project ID"
  default     = "string"
}

variable "region" {
  description = "GCP Region"
  default     = "string"
}

variable "sql_user_password" {
  description = "Cloud SQL Password"
  default     = "string"
}

variable "gke_service_account" {
  description = "GKE Service Account"
  type        = string
}

variable "logging_service_account_key_path" {
  description = "Cloud Logging Service Account Key Path"
  type        = string
}

variable "gke_service_account_key_path" {
  description = "GKE Service Account Key Path"
  type        = string
}
