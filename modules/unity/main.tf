data "azurerm_databricks_access_connector" "connector" {
  name                = var.databricks_access_connector_name
  resource_group_name = var.databricks_resource_group_name
}

resource "databricks_metastore" "primary" {
  provider      = databricks.accounts
  name          = var.metastore_name
  force_destroy = true
  region        = var.location
}

resource "databricks_metastore_assignment" "this" {
  provider     = databricks.accounts
  workspace_id = var.workspace_id
  metastore_id = databricks_metastore.primary.id
}

resource "azurerm_role_assignment" "data_blob_contributor" {
  scope                = var.data_storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_databricks_access_connector.connector.identity[0].principal_id
}

resource "azurerm_role_assignment" "data_queue_contributor" {
  scope                = var.data_storage_account_id
  role_definition_name = "Storage Queue Data Contributor"
  principal_id         = data.azurerm_databricks_access_connector.connector.identity[0].principal_id
}

resource "databricks_storage_credential" "data" {
  provider = databricks.workspace
  name     = data.azurerm_databricks_access_connector.connector.name
  azure_managed_identity {
    access_connector_id = data.azurerm_databricks_access_connector.connector.id
  }
  comment    = "Managed by TF"
  depends_on = [databricks_metastore_assignment.this]
}

resource "databricks_external_location" "data" {
  provider        = databricks.workspace
  name            = "data"
  url             = format("abfss://%s@%s.dfs.core.windows.net", var.data_filesystem_name, var.data_storage_account_name)
  credential_name = databricks_storage_credential.data.id
  comment         = "Managed by TF"
  depends_on      = [databricks_metastore_assignment.this]
}
