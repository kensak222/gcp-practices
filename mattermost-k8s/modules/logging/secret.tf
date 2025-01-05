### modules/logging/secret.tf
resource "kubernetes_namespace" "logging" {
  metadata {
    name = "logging"
  }
}

resource "kubernetes_secret" "gcp_credentials" {
  metadata {
    name      = "gcp-credentials"
    namespace = kubernetes_namespace.logging.metadata[0].name
  }

  data = {
    "service-account.json" = base64encode(file("${var.service_account_key_path}"))
  }

  depends_on = [kubernetes_namespace.logging]
}
