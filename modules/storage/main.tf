
resource "azurerm_storage_account" "data" {
  name                     = var.storage_account_data_name
  resource_group_name      = var.storage_account_resource_group_name
  location                 = var.storage_account_location_name
  tags                     = var.tags
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true
}

resource "azurerm_storage_data_lake_gen2_filesystem" "data" {
  name               = var.container_data_name
  storage_account_id = azurerm_storage_account.data.id
}

resource "azurerm_storage_data_lake_gen2_path" "landing" {
  path               = "landing"
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.data.name
  storage_account_id = azurerm_storage_account.data.id
  resource           = "directory"
}

resource "azurerm_storage_data_lake_gen2_path" "external_data" {
  path               = "${azurerm_storage_data_lake_gen2_path.landing.path}/external_data"
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.data.name
  storage_account_id = azurerm_storage_account.data.id
  resource           = "directory"
}

resource "azurerm_storage_data_lake_gen2_path" "operational_data" {
  path               = "${azurerm_storage_data_lake_gen2_path.landing.path}/operational_data"
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.data.name
  storage_account_id = azurerm_storage_account.data.id
  resource           = "directory"
}

resource "azurerm_storage_data_lake_gen2_path" "customers" {
  path               = "${azurerm_storage_data_lake_gen2_path.operational_data.path}/customers"
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.data.name
  storage_account_id = azurerm_storage_account.data.id
  resource           = "directory"
}

resource "azurerm_storage_data_lake_gen2_path" "addresses" {
  path               = "${azurerm_storage_data_lake_gen2_path.operational_data.path}/addresses"
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.data.name
  storage_account_id = azurerm_storage_account.data.id
  resource           = "directory"
}

resource "azurerm_storage_data_lake_gen2_path" "memberships" {
  path               = "${azurerm_storage_data_lake_gen2_path.operational_data.path}/memberships"
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.data.name
  storage_account_id = azurerm_storage_account.data.id
  resource           = "directory"
}

resource "azurerm_storage_data_lake_gen2_path" "memberships_2024_10" {
  path               = "${azurerm_storage_data_lake_gen2_path.memberships.path}/2024-10"
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.data.name
  storage_account_id = azurerm_storage_account.data.id
  resource           = "directory"
}

resource "azurerm_storage_data_lake_gen2_path" "memberships_2024_11" {
  path               = "${azurerm_storage_data_lake_gen2_path.memberships.path}/2024-11"
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.data.name
  storage_account_id = azurerm_storage_account.data.id
  resource           = "directory"
}

resource "azurerm_storage_data_lake_gen2_path" "memberships_2024_12" {
  path               = "${azurerm_storage_data_lake_gen2_path.memberships.path}/2024-12"
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.data.name
  storage_account_id = azurerm_storage_account.data.id
  resource           = "directory"
}

resource "azurerm_storage_data_lake_gen2_path" "memberships_2025_01" {
  path               = "${azurerm_storage_data_lake_gen2_path.memberships.path}/2025_01"
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.data.name
  storage_account_id = azurerm_storage_account.data.id
  resource           = "directory"
}

resource "azurerm_storage_data_lake_gen2_path" "orders" {
  path               = "${azurerm_storage_data_lake_gen2_path.operational_data.path}/orders"
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.data.name
  storage_account_id = azurerm_storage_account.data.id
  resource           = "directory"
}

resource "azurerm_storage_data_lake_gen2_path" "payments" {
  path               = "${azurerm_storage_data_lake_gen2_path.external_data.path}/payments"
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.data.name
  storage_account_id = azurerm_storage_account.data.id
  resource           = "directory"
}

resource "azurerm_storage_blob" "addresses" {
  for_each = fileset(path.root, "environments/dev/data/landing/operational_data/addresses/*")

  name                   = "${azurerm_storage_data_lake_gen2_path.addresses.path}/${basename(each.key)}"
  storage_account_name   = azurerm_storage_account.data.name
  storage_container_name = azurerm_storage_data_lake_gen2_filesystem.data.name
  type                   = "Block"
  content_md5            = filemd5(each.key)
  source                 = each.key
}

resource "azurerm_storage_blob" "customers" {
  for_each = fileset(path.root, "environments/dev/data/landing/operational_data/customers/*")

  name                   = "${azurerm_storage_data_lake_gen2_path.customers.path}/${basename(each.key)}"
  storage_account_name   = azurerm_storage_account.data.name
  storage_container_name = azurerm_storage_data_lake_gen2_filesystem.data.name
  type                   = "Block"
  content_md5            = filemd5(each.key)
  source                 = each.key
}

resource "azurerm_storage_blob" "orders" {
  for_each = fileset(path.root, "environments/dev/data/landing/operational_data/orders/*")

  name                   = "${azurerm_storage_data_lake_gen2_path.orders.path}/${basename(each.key)}"
  storage_account_name   = azurerm_storage_account.data.name
  storage_container_name = azurerm_storage_data_lake_gen2_filesystem.data.name
  type                   = "Block"
  content_md5            = filemd5(each.key)
  source                 = each.key
}

resource "azurerm_storage_blob" "payments" {
  for_each = fileset(path.root, "environments/dev/data/landing/external_data/payments/*")

  name                   = "${azurerm_storage_data_lake_gen2_path.payments.path}/${basename(each.key)}"
  storage_account_name   = azurerm_storage_account.data.name
  storage_container_name = azurerm_storage_data_lake_gen2_filesystem.data.name
  type                   = "Block"
  content_md5            = filemd5(each.key)
  source                 = each.key
}

resource "azurerm_storage_blob" "memberships_2024_10" {
  for_each = fileset(path.root, "environments/dev/data/landing/operational_data/memberships/2024-10/*")

  name                   = "${azurerm_storage_data_lake_gen2_path.memberships_2024_10.path}/${basename(each.key)}"
  storage_account_name   = azurerm_storage_account.data.name
  storage_container_name = azurerm_storage_data_lake_gen2_filesystem.data.name
  type                   = "Block"
  content_md5            = filemd5(each.key)
  source                 = each.key
}

resource "azurerm_storage_blob" "memberships_2024_11" {
  for_each = fileset(path.root, "environments/dev/data/landing/operational_data/memberships/2024-11/*")

  name                   = "${azurerm_storage_data_lake_gen2_path.memberships_2024_11.path}/${basename(each.key)}"
  storage_account_name   = azurerm_storage_account.data.name
  storage_container_name = azurerm_storage_data_lake_gen2_filesystem.data.name
  type                   = "Block"
  content_md5            = filemd5(each.key)
  source                 = each.key
}

resource "azurerm_storage_blob" "memberships_2024_12" {
  for_each = fileset(path.root, "environments/dev/data/landing/operational_data/memberships/2024-12/*")

  name                   = "${azurerm_storage_data_lake_gen2_path.memberships_2024_12.path}/${basename(each.key)}"
  storage_account_name   = azurerm_storage_account.data.name
  storage_container_name = azurerm_storage_data_lake_gen2_filesystem.data.name
  type                   = "Block"
  content_md5            = filemd5(each.key)
  source                 = each.key
}

resource "azurerm_storage_blob" "memberships_2025_01" {
  for_each = fileset(path.root, "environments/dev/data/landing/operational_data/memberships/2025-01/*")

  name                   = "${azurerm_storage_data_lake_gen2_path.memberships_2025_01.path}/${basename(each.key)}"
  storage_account_name   = azurerm_storage_account.data.name
  storage_container_name = azurerm_storage_data_lake_gen2_filesystem.data.name
  type                   = "Block"
  content_md5            = filemd5(each.key)
  source                 = each.key
}