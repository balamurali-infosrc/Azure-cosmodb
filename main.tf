resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_cosmosdb_account" "ac1" {
  name                = "example-cosmos-sql-acct"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  offer_type = "Standard"
  kind       = "GlobalDocumentDB" # ✅ Required for SQL API

  # enable_automatic_failover = false
  public_network_access_enabled = true

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = azurerm_resource_group.rg.location
    failover_priority = 0
  }
}


# # Cosmos DB Account
# resource "azurerm_cosmosdb_account" "ac1" {
#   name                = "example-cosmos-account"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   offer_type          = "Standard"
#   kind                = "GlobalDocumentDB"

#   consistency_policy {
#     consistency_level = "Session"
#   }

#   geo_location {
#     location          = azurerm_resource_group.rg.location
#     failover_priority = 0
#   }

#   capabilities {
#     name = "EnableServerless" # remove if using provisioned throughput
#   }

#   public_network_access_enabled = true

#   # Required by new Azure API for Mongo/Postgres compatibility
#   # enable_free_tier = false
# }

# # Cosmos DB Account
# resource "azurerm_cosmosdb_account" "ac1" {
#   name                = "example-cosmos-account"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   offer_type          = "Standard"
#   kind                = "GlobalDocumentDB"

#   consistency_policy {
#     consistency_level = "Session"
#   }

#   geo_location {
#     location          = azurerm_resource_group.rg.location
#     failover_priority = 0
#   }
# }

# # ✅ Updated: Read Cosmos DB Keys using the new data source
# data "azurerm_cosmosdb_account_keys" "key1" {
#   name                = azurerm_cosmosdb_account.ac1.name
#   resource_group_name = azurerm_resource_group.rg.name
# }


# # ✅ Recommended: Sensitive Output
# output "cosmos_account_primary_master_key" {
#   value     = data.azurerm_cosmosdb_keys.key1.primary_master_key
#   sensitive = true
# }

# Cosmos DB SQL Database
resource "azurerm_cosmosdb_sql_database" "sql1" {
  name                = "example-db"
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.ac1.name
}

# ✅ Cosmos DB SQL Container (Indexing policy defined correctly)
resource "azurerm_cosmosdb_sql_container" "con1" {
  name                = "example-container"
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.ac1.name
  database_name       = azurerm_cosmosdb_sql_database.sql1.name
  partition_key_paths = ["/departmentId"]

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }

    excluded_path {
      path = "/\"_etag\"/?"
    }
  }
}
