data "databricks_spark_version" "latest" {
  long_term_support = true
}

data "databricks_node_type" "smallest" {
  local_disk = true
  category   = "General Purpose"
}

resource "databricks_cluster" "clusters" {
  for_each                = var.clusters
  cluster_name            = each.value.name
  spark_version           = data.databricks_spark_version.latest.id
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = 10
  num_workers             = 0
  azure_attributes {
    availability = "SPOT_WITH_FALLBACK_AZURE"
  }

  spark_conf = {
    "spark.databricks.cluster.profile" : "singleNode"
  }

  data_security_mode = "SINGLE_USER"
  custom_tags = {
    "ResourceClass" = "SingleNode"
  }
}