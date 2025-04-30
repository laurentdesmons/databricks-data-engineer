# 
# global variables
#
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