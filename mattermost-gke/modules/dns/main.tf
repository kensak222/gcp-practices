resource "google_dns_managed_zone" "dns_zone" {
  name        = "mattermost-zone"
  dns_name    = "kenken-ms.com."
  description = "DNS zone for Mattermost"
}
