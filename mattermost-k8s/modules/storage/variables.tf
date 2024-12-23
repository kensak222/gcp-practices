variable "project_id" {
  description = "GCPプロジェクトID"
  type        = string
}

variable "region" {
  description = "GCPリージョン"
  type        = string
  default     = "us-central1"
}

variable "gke_service_account" {
  description = "gkeサービスアカウント"
  type        = string
}
