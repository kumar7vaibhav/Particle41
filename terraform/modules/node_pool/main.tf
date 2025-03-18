terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  required_version = ">= 0.14.9"
}

resource "azurerm_kubernetes_cluster_node_pool" "node_pool" {
  kubernetes_cluster_id        = var.kubernetes_cluster_id
  name                         = var.name
  vm_size                      = var.vm_size
  node_labels                  = var.node_labels
  zones                        = var.availability_zones
  vnet_subnet_id               = var.vnet_subnet_id
  pod_subnet_id                = var.pod_subnet_id
  auto_scaling_enabled         = var.enable_auto_scaling
  max_pods                     = var.max_pods
  max_count                    = var.max_count
  min_count                    = var.min_count
  node_count                   = var.node_count
  tags                         = var.tags

  lifecycle {
    ignore_changes = [
        tags
    ]
  }
}