terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "resource_group" {
  source      = "azurerm/resources/azure//modules/resource_group"
  location    = "westeurope"
  environment = "dev"
  workload    = "example"
  instance    = "001"
}

module "public_ip" {
  source              = "azurerm/resources/azure//modules/public_ip"
  resource_group_name = module.resource_group.name
  location            = "westeurope"
  environment         = "dev"
  workload            = "bast"
  instance            = "001"
}

module "bastion_host" {
  source              = "azurerm/resources/azure//modules/bastion_host"
  resource_group_name = module.resource_group.name
  location            = "westeurope"
  environment         = "dev"
  workload            = "hub"
  instance            = "001"
  public_ip_id        = module.public_ip.id
}