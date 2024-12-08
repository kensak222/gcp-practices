# インフラ構築後に必要となる情報（例: GKEクラスタ名、Cloud SQLの接続情報など）を出力
output "kubernetes_cluster_endpoint" {
  description = "GKEクラスタのエンドポイント"
  value       = module.gke.endpoint
}

output "database_connection_name" {
  description = "Cloud SQL接続名"
  value       = module.cloud_sql.connection_name
}
