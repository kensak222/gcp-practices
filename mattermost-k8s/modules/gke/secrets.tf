### mattermost-k8s/modules/gke/secrets.tf
resource "kubernetes_namespace" "mattermost" {
  metadata {
    name = "mattermost"
  }
}

resource "kubernetes_secret" "mattermost_db_secret" {
  metadata {
    name      = "mattermost-db-secret"
    namespace = kubernetes_namespace.mattermost.metadata[0].name
  }

  data = {
    MM_SQLSETTINGS_DATASOURCE = "postgres://mattermost:${var.sql_user_password}@mattermost-db:5432/mattermost?sslmode=disable&connect_timeout=10"
    POSTGRES_PASSWORD         = var.sql_user_password
  }
}
