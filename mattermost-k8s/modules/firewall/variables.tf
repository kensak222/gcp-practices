variable "network_name" {
  description = "The name of the VPC network"
  default     = "default"
}

variable "firewall_name" {
  description = "The name of the firewall rule"
  default     = "allow-https"
}

variable "target_tags" {
  description = "Target tags for the firewall rule"
  default     = ["mattermost-cluster"]
}
