# Resource Group Configuration
variable "resource_group_name" {
  description = "Specifies the resource group name"
  default     = "Terraform-AKS-RG"
  type        = string
}

# Resource Tagging
variable "tags" {
  description = "(Optional) Specifies tags for all the resources"
  type        = map(string)
  default = {
    createdWith = "Terraform"
  }
}

# Location Configuration
variable "location" {
  description = "Specifies the location for the resource group and all the resources"
  default     = "centralindia"
  type        = string
}

# Network Configuration
variable "vnet_name" {
  description = "Specifies the name of the virtual network"
  default     = "Main-VNet"
  type        = string
}

variable "vnet_address_space" {
  description = "Specifies the address space of the virtual network"
  default     = ["10.0.0.0/16"]
  type        = list(string)
}

variable "public_subnet_name" {
  description = "Specifies the name of the public subnet"
  default     = "PublicSubnet"
  type        = string
}

variable "public_subnet_address_prefix" {
  description = "Specifies the address prefix of the subnet that hosts the default node pool"
  default     = ["10.0.3.0/24"]
  type        = list(string)
}

# AKS Node Pool Subnet Configuration
variable "default_node_pool_subnet_name" {
  description = "Specifies the name of the subnet that hosts the default node pool"
  default     = "PrivateSubnet01"
  type        = string
}

variable "default_node_pool_subnet_address_prefix" {
  description = "Specifies the address prefix of the subnet that hosts the default node pool"
  default     = ["10.0.1.0/24"]
  type        = list(string)
}

# AKS Cluster Configuration
variable "aks_cluster_name" {
  description = "(Required) Specifies the name of the AKS cluster."
  default     = "Terraform-AKS-Cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Specifies the AKS Kubernetes version"
  default     = "1.30.9"
  type        = string
}

variable "default_node_pool_name" {
  description = "Specifies the name of the default node pool"
  default     = "system"
  type        = string
}

variable "default_node_pool_vm_size" {
  description = "Specifies the vm size of the default node pool"
  default     = "Standard_DS2_v2"
  type        = string
}

variable "default_node_pool_availability_zones" {
  description = "Specifies the availability zones of the default node pool"
  default     = ["1", "2", "3"]
  type        = list(string)
}

# AKS Node Pool Scaling Configuration
variable "default_node_pool_max_pods" {
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  type        = number
  default     = 30
}

variable "default_node_pool_max_count" {
  description = "(Required) The maximum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be greater than or equal to min_count."
  type        = number
  default     = 1
}

variable "default_node_pool_min_count" {
  description = "(Required) The minimum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be less than or equal to max_count."
  type        = number
  default     = 1
}

# AKS Network Configuration
variable "network_dns_service_ip" {
  description = "Specifies the DNS service IP"
  default     = "10.2.0.10"
  type        = string
}

variable "network_plugin" {
  description = "Specifies the network plugin of the AKS cluster"
  default     = "azure"
  type        = string
}

variable "network_service_cidr" {
  description = "Specifies the service CIDR"
  default     = "10.2.0.0/24"
  type        = string
}

variable "default_node_pool_enable_auto_scaling" {
  description = "(Optional) Whether to enable auto-scaler. Defaults to true."
  type        = bool
  default     = true
}

variable "additional_node_pool_name" {
  description = "(Required) Specifies the name of the node pool."
  type        = string
  default     = "additional"
}

variable "additional_node_pool_vm_size" {
  description = "(Required) The SKU which should be used for the Virtual Machines used in this Node Pool. Changing this forces a new resource to be created."
  type        = string
  default     = "Standard_DS2_v2"
}

variable "additional_node_pool_node_labels" {
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in this Node Pool. Changing this forces a new resource to be created."
  type        = map(any)
  default     = {}
}

variable "additional_node_pool_availability_zones" {
  description = "(Optional) A list of Availability Zones where the Nodes in this Node Pool should be created in. Changing this forces a new resource to be created."
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "additional_node_pool_enable_auto_scaling" {
  description = "(Optional) Whether to enable auto-scaler. Defaults to false."
  type        = bool
  default     = true
}

variable "additional_node_pool_max_pods" {
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  type        = number
  default     = 30
}

variable "additional_node_pool_max_count" {
  description = "(Required) The maximum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be greater than or equal to min_count."
  type        = number
  default     = 1
}

variable "additional_node_pool_min_count" {
  description = "(Required) The minimum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be less than or equal to max_count."
  type        = number
  default     = 1
}

variable "additional_node_pool_node_count" {
  description = "(Optional) The initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be a value in the range min_count - max_count."
  type        = number
  default     = 1
}

variable "additional_node_pool_subnet_name" {
  description = "Specifies the name of the subnet that hosts the default node pool"
  default     = "PrivateSubnet02"
  type        = string
}

variable "additional_node_pool_subnet_address_prefix" {
  description = "Specifies the address prefix of the subnet that hosts the additional node pool"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "appgateway_name" {
  description = "Name of the Application Gateway"
  type        = string
  default     = "aks-appgw"
}

variable "appgateway_public_ip_name" {
  description = "Name of the public IP for Application Gateway"
  type        = string
  default     = "aks-appgw-pip"
}