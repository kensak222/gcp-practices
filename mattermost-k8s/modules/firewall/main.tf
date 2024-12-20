### mattermost-k8s/modules/firewall/main.tf
# Firewallルールを最小権限で設定する
# 必要なトラフィックのみを許可し、不要なアクセスをブロックする
# httpsトラフィックを許可するルールを設定
resource "google_compute_firewall" "allow_https" {
  name        = var.firewall_name
  description = "Allow HTTPS traffic to Mattermost app"
  network     = var.network_id

  allow {
    protocol = "tcp"
    ports    = ["80","443"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = var.target_tags
}

# 内部通信の許可
# GKEクラスタ内のPodやサービス間の通信を許可
resource "google_compute_firewall" "allow_internal" {
  name        = "allow-internal"
  description = "Allow internal communication between resources"
  network     = var.network_id

  # 内部IPアドレス10.0.0.0/16からの受信パケットを全て許可
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = ["10.0.0.0/16"]
}

### 必要が出たら以下のコメントアウトを解除する
# 管理者がSSHアクセスする必要がある場合、特定のIPアドレスに限定する必要がある
# resource "google_compute_firewall" "allow_ssh" {
#   name        = "allow-ssh-mattermost"
#   description = "Allow SSH access from specific IPs"
#   network     = google_compute_network.mattermost_vpc.name

#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }

#   source_ranges = ["xxx.x.xxx.x/xx"]  # 管理者のIPアドレスに変更

#   target_tags = ["mattermost-app"]
# }
