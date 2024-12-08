# variables.tf: モジュールが必要とするパラメータを柔軟に設定可能にする。
variable "project_id" {
  description = "GCPのプロジェクトID"
  default     = "mattermost-kenken"
}

variable "region" {
  description = "GCPのリージョン"
  default     = "us-central1"
}
