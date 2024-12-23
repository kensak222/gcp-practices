output "vpc_network_id" {
  description = "The ID of the Mattermost VPC network"
  value       = google_compute_network.mattermost_vpc.id
}

output "mattermost_subnet_id" {
  description = "The ID of the Mattermost Subnet"
  value       = google_compute_subnetwork.mattermost_subnet.id
}
