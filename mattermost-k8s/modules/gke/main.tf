resource "google_container_cluster" "primary" {
  name     = "mattermost-cluster"
  location = var.region

  initial_node_count = 1

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 20
  }

  release_channel {
    # 安定版の機能リリースを使用
    channel = "REGULAR"
  }
}
