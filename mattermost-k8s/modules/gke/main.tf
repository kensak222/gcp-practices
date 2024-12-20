### mattermost-k8s/modules/gke/main.tf
resource "google_container_cluster" "primary" {
  name     = "mattermost-cluster"
  location = var.region

  # 勉強目的に作りやすくするため、削除保護を無効にする
  deletion_protection = false

  networking_mode = "VPC_NATIVE"
  remove_default_node_pool = true
  initial_node_count = 1

  # default ネットワークではなく mattermost-vpc を参照するように設定
  network    = var.network_id
  subnetwork = var.mattermost_subnet_id

  # GKEクラスタをプライベートクラスタとして構成し、ノードへの外部IP割り当てを防ぐ
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  node_config {
    machine_type = "e2-small"
    disk_size_gb = 20
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    tags = ["mattermost-app"]
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

# Nodeプールを明示的に追加
resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool"
  cluster    = google_container_cluster.primary.id
  location   = var.region
  node_count = 1

  node_config {
    machine_type = "e2-small"
    disk_size_gb = 20
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    tags = ["mattermost-app"]
  }
}
