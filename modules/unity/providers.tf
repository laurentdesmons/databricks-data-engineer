# 
# providers
#
terraform {
  required_version = ">= 0.12.24"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.3.0"
    }
    databricks = {
      source = "databricks/databricks"
    }
  }
}

provider "databricks" {
  alias                       = "workspace"
  host                        = var.workspace_url
  azure_workspace_resource_id = var.workspace_id
}

provider "databricks" {
  alias      = "accounts"
  host       = "https://accounts.azuredatabricks.net"
  account_id = var.databricks_account_id
}