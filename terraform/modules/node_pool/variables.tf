variable "name" {
  description = "(Required) Specifies the name of the node pool."
  type        = string
}

variable "kubernetes_cluster_id" {
  description = "(Required) Specifies the resource id of the AKS cluster."
  type        = string
}

variable "vm_size" {
  description = "(Required) The SKU which should be used for the Virtual Machines used in this Node Pool. Changing this forces a new resource to be created."
  type        = string
}

variable "availability_zones" {
  description = "(Optional) A list of Availability Zones where the Nodes in this Node Pool should be created in. Changing this forces a new resource to be created."
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "enable_auto_scaling" {
  description = "(Optional) Whether to enable auto-scaler. Defaults to false."
  type        = bool
  default     = false
}

variable "max_pods" {
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  type        = number
  default     = 30
}

variable "node_labels" {
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in this Node Pool. Changing this forces a new resource to be created."
  type        = map(any)
  default     = {}
}

variable "tags" {
  description = "(Optional) Specifies the tags of the network security group"
  type = map(string)
  default     = {}
}

variable "vnet_subnet_id" {
  description = "(Optional) The ID of the Subnet where this Node Pool should exist."
  type        = string
  default     = null
}

variable "pod_subnet_id" {
  description = "(Optional) The ID of the Subnet where the pods in the default Node Pool should exist. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "max_count" {
  description = "(Required) The maximum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be greater than or equal to min_count."
  type        = number
  default     = 1
}

variable "min_count" {
  description = "(Required) The minimum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be less than or equal to max_count."
  type        = number
  default     = 1
}

variable "node_count" {
  description = "(Optional) The initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be a value in the range min_count - max_count."
  type        = number
  default     = 1
}

