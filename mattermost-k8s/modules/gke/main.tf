resource "google_container_cluster" "primary" {
  name     = "mattermost-cluster"
  location = var.region

  initial_node_count = 1

  node_config {
    machine_type = "e2-small"
    disk_size_gb = 20
  }

  release_channel {
    # 安定版の機能リリースを使用
    channel = "REGULAR"
  }

  # クラスタ作成後に認証情報を取得
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${self.name} --zone ${self.location} --project ${var.project_id}"
  }
}
