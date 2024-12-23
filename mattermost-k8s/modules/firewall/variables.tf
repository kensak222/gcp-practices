variable "firewall_name" {
  description = "The name of the firewall rule"
  type        = string
  default     = "allow-https"
}

variable "target_tags" {
  description = "Target tags for the firewall rule"
  default     = ["mattermost-app"]
}

variable "network_id" {
  description = "The ID of the VPC network"
  type        = string
}
