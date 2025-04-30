resource "azurerm_databricks_workspace" "workspace" {
  name                = var.workspace.name
  resource_group_name = var.workspace.resource_group_name
  location            = var.workspace.location
  sku                 = var.workspace.sku

  tags = var.tags
}
