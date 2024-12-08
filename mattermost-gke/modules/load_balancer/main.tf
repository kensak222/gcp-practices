resource "google_compute_global_address" "default" {
  name = "mattermost-global-ip"
}

# SSL証明書、バックエンド、フロントエンドの設定は必要に応じて追加
