# 
# global variables
#
variable "tenant_id" {
  type        = string
  description = "The tenant id."
}

variable "subscription_id" {
  type        = string
  description = "The subscription id."
}

variable "databricks_account_id" {
  type        = string
  description = "The databricks account id."
}

variable "location" {
  type        = string
  description = "Location where the resources are going to be created."
}

variable "tags" {
  type        = map(any)
  description = "Tags to apply to the resources"
}

#
# resource groups
#
variable "resource_groups" {
  type = map(object({
    name = string
  }))
  description = "The resource groups."
}

#
# workspace
#
variable "workspace" {
  type = object({
    name               = string
    resource_group_key = string
    sku                = string
  })
  description = "The workspace."
}

#
# clusters
#
variable "clusters" {
  type = map(object({
    name = string
  }))
  description = "The clusters."
}

#
# notebooks
#
variable "notebooks" {
  type = map(object({
    source = string
    path   = string
  }))
  description = "The notebooks."
}

variable "metastore_name" {
  type        = string
  description = "The name of the metastore."
}

#
# storage
#
variable "databricks_access_connector_name" {
  type        = string
  description = "The name of the existing databricks access connector."
}

variable "databricks_resource_group_name" {
  type        = string
  description = "The name of the existing databricks resource group."
}

variable "storage_account_data_name" {
  type        = string
  description = "The name of the storage account for data."
}

variable "container_data_name" {
  type        = string
  description = "The name of the container for data."
}