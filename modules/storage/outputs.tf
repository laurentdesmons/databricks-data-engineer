#  
# outputs
#
output "data_storage_account" {
  value       = azurerm_storage_account.data
  description = "The data storage account."
}

output "data_filesystem" {
  value       = azurerm_storage_data_lake_gen2_filesystem.data
  description = "The fiel system."
}