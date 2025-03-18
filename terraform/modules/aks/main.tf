terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  required_version = ">= 0.14.9"
}

data "azurerm_application_gateway" "appgateway" {
  name                = var.appgateway_name
  resource_group_name = var.appgateway_resource_group_name
}

# Deploy Azure Kubernetes Service (AKS) cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                             = var.name
  location                         = var.location
  resource_group_name              = var.resource_group_name
  kubernetes_version               = var.kubernetes_version
  dns_prefix                       = var.dns_prefix
  sku_tier                         = var.sku_tier

  # Configure the default node pool
  default_node_pool {
    name                 = var.default_node_pool_name
    vm_size              = var.default_node_pool_vm_size
    vnet_subnet_id       = var.vnet_subnet_id
    pod_subnet_id        = var.pod_subnet_id
    zones                = var.default_node_pool_availability_zones
    auto_scaling_enabled = var.default_node_pool_enable_auto_scaling
    max_pods             = var.default_node_pool_max_pods
    max_count            = var.default_node_pool_max_count
    min_count            = var.default_node_pool_min_count
    node_count           = var.default_node_pool_node_count
    tags                 = var.tags
  }

  # Configure cluster identity
  identity {
    type = "SystemAssigned"
  }

    ingress_application_gateway {
    gateway_id = data.azurerm_application_gateway.appgateway.id
  }

  # Configure Internal Load Balancer
  network_profile {
    network_plugin = var.network_plugin              #azure
    dns_service_ip = var.network_dns_service_ip
    outbound_type  = var.outbound_type
    service_cidr   = var.network_service_cidr
  }

  # Configure lifecycle rules
  lifecycle {
    ignore_changes = [
      kubernetes_version,
      route_table_id,
      tags
    ]
  }
}