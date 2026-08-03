terraform {
  required_version = ">= 1.8.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  } 
  backend "azurerm" {
    resource_group_name  = "rg-github-actions-demo"
    storage_account_name = "stiacdemo001"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}

  provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

