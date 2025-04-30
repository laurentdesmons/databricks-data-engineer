# 
# global variables
#
variable "tags" {
  type        = map(any)
  description = "Tags to apply to the resources"
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