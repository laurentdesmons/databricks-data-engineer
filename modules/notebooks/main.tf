data "databricks_current_user" "me" {
}

resource "databricks_notebook" "notebooks" {
  for_each = var.notebooks
  source   = "${path.root}${each.value.source}"
  path     = "${data.databricks_current_user.me.home}${each.value.path}"
}
