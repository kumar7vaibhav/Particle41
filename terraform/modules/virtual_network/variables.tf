variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location where resources will be created"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
  default     = {}
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "VNET address space"
  type        = list(string)
}

variable "subnets" {
  description = "Subnets configuration"
  type = list(object({
    name                                           = string
    address_prefixes                               = list(string)
    private_endpoint_network_policies              = string
    private_link_service_network_policies_enabled  = bool
  }))
}

