### modules/monitoring/helm.tf
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "prometheus" {
  depends_on = [kubernetes_namespace.monitoring]

  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  version    = "15.8.0"
}

resource "helm_release" "grafana" {
  depends_on = [kubernetes_namespace.monitoring]

  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  version    = "8.8.2"

  values = [
    templatefile("${path.root}/k8s/monitoring/grafana-values.yaml", {
      project_id = var.project_id
    })
  ]
}
