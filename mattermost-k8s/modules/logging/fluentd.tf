### modules/logging/fluentd.tf
resource "kubernetes_config_map" "fluentd_config" {
  metadata {
    name      = "fluentd-config"
    namespace = kubernetes_namespace.logging.metadata[0].name
  }

  data = {
    "fluent.conf" = <<EOT
<source>
  @type forward
  port 24224
</source>
<match **>
  @type stdout
</match>
EOT
  }
}

resource "kubernetes_manifest" "fluentd" {
  manifest = yamldecode(
    templatefile(
      "${path.root}/k8s/logging/fluentd.yaml.template", 
      { google_project_id = var.project_id }
    )
  )

  depends_on = [kubernetes_namespace.logging, kubernetes_config_map.fluentd_config]
}
