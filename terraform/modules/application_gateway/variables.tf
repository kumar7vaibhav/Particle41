variable "resource_group_name" {
  type        = string
  description = "Resource group"
}

variable "appgateway_name" {
  type        = string
  description = "Application name. Use only lowercase letters and numbers"
}

variable "location" {
  type        = string
  description = "Azure region where to create resources."
  default     = "centralindia"
}

variable "VIRTUAL_NETWORK_NAME" {
  type        = string
  description = "Virtual network name. This service will create subnets in this network."
  default     = "Main-VNet"
}

variable "appgateway_public_ip_name" {
  type        = string
  description = "PUBLIC IP. This service will create subnets in this network."
  default     = "AppGateway-PublicIP"
}

variable "public_subnet_name" {
  type        = string
  description = "Public subnet name"
  default     = "PublicSubnet"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet where the Application Gateway will be deployed"
}
