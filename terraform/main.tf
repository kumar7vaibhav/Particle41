terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  required_version = ">= 0.14.9"
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Local variables for route table configuration
locals {
  route_table_name       = "DefaultRouteTable"
  route_name             = "RouteToInternet"
}

data "azurerm_client_config" "current" {
}

# Create the main resource group for all resources
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Deploy the combined Virtual Network
module "aks_network" {
  source              = "./modules/virtual_network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  vnet_name           = var.vnet_name
  address_space       = var.vnet_address_space
  tags                = var.tags

  # Configure the subnets
  subnets = [
    {
      name : var.public_subnet_name
      address_prefixes : var.public_subnet_address_prefix
      private_endpoint_network_policies : "Disabled"
      private_link_service_network_policies_enabled : false
    },
    {
      name : var.default_node_pool_subnet_name
      address_prefixes : var.default_node_pool_subnet_address_prefix
      private_endpoint_network_policies : "Enabled"
      private_link_service_network_policies_enabled : false
    },
    {
      name : var.additional_node_pool_subnet_name
      address_prefixes : var.additional_node_pool_subnet_address_prefix
      private_endpoint_network_policies : "Enabled"
      private_link_service_network_policies_enabled : false
    }
  ]
}

module "appgateway" {
  source                    = "./modules/application_gateway"
  resource_group_name       = azurerm_resource_group.rg.name
  appgateway_name          = var.appgateway_name
  location                 = var.location
  VIRTUAL_NETWORK_NAME     = var.vnet_name
  appgateway_public_ip_name = var.appgateway_public_ip_name
  public_subnet_name       = var.public_subnet_name
  subnet_id                = module.aks_network.subnet_ids[var.public_subnet_name]
  
  depends_on = [module.aks_network]
}

module "routetable" {
  source               = "./modules/route_table"
  resource_group_name  = azurerm_resource_group.rg.name
  location             = var.location
  route_table_name     = local.route_table_name
  route_name           = local.route_name
  subnets_to_associate = {
    (var.default_node_pool_subnet_name) = {
      subscription_id      = data.azurerm_client_config.current.subscription_id
      resource_group_name  = azurerm_resource_group.rg.name
      virtual_network_name = module.aks_network.name
    }
    (var.additional_node_pool_subnet_name) = {
      subscription_id      = data.azurerm_client_config.current.subscription_id
      resource_group_name  = azurerm_resource_group.rg.name
      virtual_network_name = module.aks_network.name
    }
  }
}

# Deploy Azure Kubernetes Service (AKS) cluster
# This is a private AKS cluster with user-defined routing for outbound traffic
module "aks_cluster" {
  source                                = "./modules/aks"
  name                                  = var.aks_cluster_name
  location                              = var.location
  resource_group_name                   = azurerm_resource_group.rg.name
  kubernetes_version                    = var.kubernetes_version
  dns_prefix                            = lower(var.aks_cluster_name)
  default_node_pool_name                = var.default_node_pool_name
  default_node_pool_vm_size             = var.default_node_pool_vm_size
  vnet_subnet_id                        = module.aks_network.subnet_ids[var.default_node_pool_subnet_name]
  default_node_pool_enable_auto_scaling = var.default_node_pool_enable_auto_scaling
  default_node_pool_availability_zones  = var.default_node_pool_availability_zones
  default_node_pool_max_pods            = var.default_node_pool_max_pods
  default_node_pool_max_count           = var.default_node_pool_max_count
  default_node_pool_min_count           = var.default_node_pool_min_count
  tags                                  = var.tags
  network_dns_service_ip                = var.network_dns_service_ip
  network_plugin                        = var.network_plugin
  outbound_type                         = "userDefinedRouting"
  network_service_cidr                  = var.network_service_cidr
  
  # Application Gateway configuration
  appgateway_name                = var.appgateway_name
  appgateway_resource_group_name = azurerm_resource_group.rg.name

  depends_on = [module.appgateway]
}


# Additional Node Pool
module "node_pool" {
  source                = "./modules/node_pool"
  kubernetes_cluster_id = module.aks_cluster.id
  name                  = var.additional_node_pool_name
  vm_size               = var.additional_node_pool_vm_size
  node_labels           = var.additional_node_pool_node_labels
  availability_zones    = var.additional_node_pool_availability_zones
  vnet_subnet_id        = module.aks_network.subnet_ids[var.additional_node_pool_subnet_name]
  enable_auto_scaling   = var.additional_node_pool_enable_auto_scaling
  max_pods              = var.additional_node_pool_max_pods
  max_count             = var.additional_node_pool_max_count
  min_count             = var.additional_node_pool_min_count
  node_count            = var.additional_node_pool_node_count
  tags                  = var.tags

}