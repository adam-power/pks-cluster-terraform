variable "subscription_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "dns_zone_name" {
  type = string
}

variable "dns_zone_resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "master_nics" {
  type = list
}

variable "resource_group_name" {
  type = string
}

variable "tenant_id" {
  type = string
}

// Optional variables
variable "cloud_name" {
  description = "The Azure cloud environment to use. Available values at https://www.terraform.io/docs/providers/azurerm/#environment"
  default     = "public"
  type        = string
}

variable "master_asg" {
  description = "An application security group to add to the master VMs"
  default     = ""
  type        = string
}
