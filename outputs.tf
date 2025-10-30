output "cosmos_account_endpoint" {
  value = azurerm_cosmosdb_account.ac1.endpoint
}

# output "cosmos_account_primary_master_key" {
#   value     = azurerm_cosmosdb_account.example.primary_master_key
#   sensitive = true
# }
# output "cosmos_account_primary_master_key" {
#   value     = data.azurerm_cosmosdb_account_keys.key1.primary_master_key
#   sensitive = true
# }


output "database_name" {
  value = azurerm_cosmosdb_sql_database.sql1.name
}

output "container_name" {
  value = azurerm_cosmosdb_sql_container.con1.name
}
