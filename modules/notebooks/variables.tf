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