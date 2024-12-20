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
