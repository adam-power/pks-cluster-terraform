variable "cluster_name" {
  type        = "string"
  description = "PKS cluster name"
}

variable "access_key" {
  type        = "string"
  description = "AWS access key ID"
}

variable "secret_key" {
  type        = "string"
  description = "AWS secret access key"
}

variable "region" {
  type        = "string"
  description = "AWS region"
}

# variable "availability_zones" {
#   type        = "list"
#   description = "AWS availability zones"
# }

variable "subnet_ids" {
  type        = "list"
  description = "AWS subnet IDs to attach the ELB to"
}

variable "master_security_group" {
  type        = "string"
  description = "AWS security group to associate to the ELB"
}

variable "master_ids" {
  type        = "list"
  description = "AWS instance IDs of Kubernetes master VM"
}

variable "zone_id" {
  type        = "string"
  description = "AWS Route53 hosted zone ID"
}