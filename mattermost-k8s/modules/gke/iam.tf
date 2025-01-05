### modules/gke/iam.tf
resource "google_project_iam_member" "gke_access_roles" {
    for_each = toset([
        "roles/container.admin",         # GKEクラスタの管理
        "roles/logging.logWriter",       # Stackdriver Logging
        "roles/monitoring.metricWriter", # Stackdriver Monitoring
    ])

    project = var.project_id
    role    = each.key
    member  = "serviceAccount:${var.gke_service_account}"
}
