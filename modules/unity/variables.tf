variable "location" {
  type        = string
  description = "Location where the resources are going to be created."
}

variable "databricks_account_id" {
  type        = string
  description = "The id of the databricks account."
}



variable "metastore_name" {
  type        = string
  description = "The name of the metastore."
}

variable "workspace_url" {
  type        = string
  description = "The url of the workspace."
}

variable "workspace_id" {
  type        = number
  description = "The id of the workspace."
}

variable "databricks_access_connector_name" {
  type        = string
  description = "The name of the existing databricks access connector."
}

variable "databricks_resource_group_name" {
  type        = string
  description = "The name of the existing databricks resource group."
}

variable "data_storage_account_id" {
  type        = string
  description = "The id of the data storage account."
}

variable "data_storage_account_name" {
  type        = string
  description = "The name of the data storage account."
}

variable "data_filesystem_name" {
  type        = string
  description = "The name of the data file system."
}