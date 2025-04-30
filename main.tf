# 
# root module
#
locals {
  /*   network_resource_group_name      = module.resource_groups.resource_groups["network"].name
  databases_resource_group_name    = module.resource_groups.resource_groups["databases"].name
  app_services_resource_group_name = module.resource_groups.resource_groups["app_services"].name
  storage_resource_group_name      = module.resource_groups.resource_groups["storage"].name */
}

#
# resource groups
#
module "resource_groups" {
  source = "./modules/resourcegroups"
  providers = {
    azurerm = azurerm.sg_sub
  }
  location        = var.location
  resource_groups = var.resource_groups
  tags            = var.tags
}

#
# workspace
#
module "workspace" {
  source = "./modules/workspace"
  providers = {
    azurerm = azurerm.sg_sub
  }
  workspace = {
    name                = var.workspace.name
    resource_group_name = module.resource_groups.resource_groups[var.workspace.resource_group_key].name
    location            = module.resource_groups.resource_groups[var.workspace.resource_group_key].location
    sku                 = var.workspace.sku
  }
  tags = var.tags
}

#
# clusters
#
module "clusters" {
  source = "./modules/clusters"
  providers = {
    azurerm    = azurerm.sg_sub
    databricks = databricks.workspace
  }

  clusters = var.clusters
  tags     = var.tags

  depends_on = [module.workspace]
}


#
# notebooks
#
module "notebooks" {
  source = "./modules/notebooks"
  providers = {
    azurerm    = azurerm.sg_sub
    databricks = databricks.workspace
  }

  notebooks = var.notebooks

  depends_on = [module.clusters]
}

#
# storage
#
module "storage" {
  source = "./modules/storage"
  providers = {
    azurerm    = azurerm.sg_sub
    databricks = databricks.workspace
  }

  storage_account_data_name           = var.storage_account_data_name
  storage_account_resource_group_name = module.resource_groups.resource_groups[var.workspace.resource_group_key].name
  storage_account_location_name       = module.resource_groups.resource_groups[var.workspace.resource_group_key].location
  container_data_name                 = var.container_data_name
  tags                                = var.tags
}

#
# unity
#
module "unity" {
  source = "./modules/unity"
  providers = {
    azurerm    = azurerm.sg_sub
    databricks = databricks.accounts
  }

  location                         = module.resource_groups.resource_groups[var.workspace.resource_group_key].location
  databricks_account_id            = var.databricks_account_id
  metastore_name                   = var.metastore_name
  workspace_url                    = module.workspace.workspace.workspace_url
  workspace_id                     = module.workspace.workspace.workspace_id
  databricks_access_connector_name = var.databricks_access_connector_name
  databricks_resource_group_name   = var.databricks_resource_group_name
  data_storage_account_id          = module.storage.data_storage_account.id
  data_storage_account_name        = module.storage.data_storage_account.name
  data_filesystem_name             = module.storage.data_filesystem.name
}


