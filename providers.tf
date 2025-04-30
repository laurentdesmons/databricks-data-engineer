# 
# providers
#
terraform {
  required_version = ">= 0.12.24"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.30.0"
    }

    databricks = {
      source  = "databricks/databricks"
      version = ">=1.35.1"
    }
  }

  backend "azurerm" {
  }
}

# 
# Azure provider for the SG subscription
#
provider "azurerm" {
  alias           = "sg_sub"
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "databricks" {
  alias                       = "workspace"
  host                        = module.workspace.workspace.workspace_url
  azure_workspace_resource_id = module.workspace.workspace.id
}

provider "databricks" {
  alias      = "accounts"
  host       = "https://accounts.azuredatabricks.net"
  account_id = var.databricks_account_id
}

