# 
# resource groups
#
resource "azurerm_resource_group" "resource_groups" {
  for_each = var.resource_groups
  name     = each.value.name
  location = var.location
  tags     = var.tags
}