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

  # Stackdriver LoggingとMonitoringを有効化
  logging_service   = "logging.googleapis.com/kubernetes" # ログ送信先
  monitoring_service = "monitoring.googleapis.com/kubernetes" # 監視データ送信先

  # クラスタの監視機能（Stackdriver Monitoring）を有効化
  # クラスタ全体のログやメトリクスをStackdriverに送信するため有効化
  monitoring_config {
    enable_components = [
      "SYSTEM_COMPONENTS",
      "APISERVER",
      "SCHEDULER",
      "CONTROLLER_MANAGER"
    ]
  }

  # クラスタのログ収集機能（Stackdriver Logging）を有効化
  logging_config {
    enable_components = [
      "SYSTEM_COMPONENTS",
      "WORKLOADS"
    ]
  }

  # 監視とログ管理の導入
  # Kubernetesアドオン構成
  addons_config {
    # Cloud Runの無効化（不要な場合、コスト削減のため）
    cloudrun_config {
      disabled = true
    }

    # HTTPロードバランシングを有効化（Ingressのサポート）
    # Nginx Ingressなどの構成で外部トラフィックを処理可能に
    http_load_balancing {
      disabled = false
    }

    # Podやサービスのリソース使用率に基づいてスケールアップ/ダウンを可能にする
    # リソース負荷に応じてPod数を動的に調整
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  # GKEクラスタをプライベートクラスタとして構成し、ノードへの外部IP割り当てを防ぐ
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  # 勉強用にマスター認可ネットワークを簡便に設定しているが、本来はきちんと設定する
  # 例えば別VPC上で管理用の安いGCEを建てて、そこからのアクセスのみ許可するとか
  master_authorized_networks_config {
    # 自宅やネットワーク環境によっては、IPアドレスが変更される可能性があるため、
    # curl ifconfig.me で都度確認して設定する
    cidr_blocks {
      cidr_block   = "152.165.116.138/32" # 必要に応じて範囲を制限
      display_name = "home-ip-access"
    }

    # 複数のIPを許可する場合、以下のように設定する
    # cidr_blocks {
    #   cidr_block   = "198.51.100.10/32" # 追加するIP
    #   display_name = "Additional-IP"
    # }
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
