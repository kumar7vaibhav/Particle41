terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  required_version = ">= 0.14.9"
}

data "azurerm_subnet" "PublicSubnet" {
  name                 = var.public_subnet_name
  virtual_network_name = var.VIRTUAL_NETWORK_NAME
  resource_group_name  = var.resource_group_name
  
}

# Application Gateway
locals {
  backend_address_pool_name      = "${var.VIRTUAL_NETWORK_NAME}-beap"
  frontend_port_name             = "${var.VIRTUAL_NETWORK_NAME}-feport"
  frontend_ip_configuration_name = "${var.VIRTUAL_NETWORK_NAME}-feip"
  http_setting_name              = "${var.VIRTUAL_NETWORK_NAME}-be-htst"
  http_listener_name             = "${var.VIRTUAL_NETWORK_NAME}-httplstn"
  request_routing_rule_name      = "${var.VIRTUAL_NETWORK_NAME}-rqrt"
}

# Public IP
resource "azurerm_public_ip" "public_ip" {
  name                = var.appgateway_public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Application gateway
resource "azurerm_application_gateway" "appgateway" {
  name                = var.appgateway_name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }
  frontend_port {
    name = "httpsPort"
    port = 443
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  http_listener {
    name                           = local.http_listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.http_listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
    priority                   = "100"
  }
  depends_on = [azurerm_public_ip.public_ip]

  lifecycle {
    ignore_changes = [
      tags,
      backend_address_pool,
      backend_http_settings,
      probe,
      identity,
      request_routing_rule,
      url_path_map,
      frontend_port,
      http_listener,
      redirect_configuration
    ]
  }
}