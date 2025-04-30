# 
# global variables
#
variable "tags" {
  type        = map(any)
  description = "Tags to apply to the resources"
}

#
# workspaces
#
variable "workspace" {
  type = object({
    name                = string
    resource_group_name = string
    location            = string
    sku                 = string
  })
  description = "The workspace."
}

