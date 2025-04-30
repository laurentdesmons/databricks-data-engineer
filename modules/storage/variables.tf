# 
# global variables
#
variable "tags" {
  type        = map(any)
  description = "Tags to apply to the resources"
}



variable "storage_account_data_name" {
  type        = string
  description = "The name of the storage account for data."
}

variable "storage_account_resource_group_name" {
  type        = string
  description = "The name of the resource group for the storage account for data."
}

variable "storage_account_location_name" {
  type        = string
  description = "The location of the storage account for data."
}

variable "container_data_name" {
  type        = string
  description = "The name of the container for data."
}
