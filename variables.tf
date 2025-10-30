variable "location" { 
    type = string 
    default = "eastus"
     }
variable "resource_group_name" {
     type = string
 default = "rg-cosmos-demo"
  }
variable "cosmos_account_name" { 
    type = string
     default = "cosmos-demo-acc"
      } # must be globally unique
variable "database_name" { 
    type = string
     default = "appdb"
      }
variable "container_name" {
     type = string
 default = "items" 
 }
variable "partition_key_path" { 
    type = string
 default = "/partitionKey"
  }

# feature toggles / options
variable "enable_automatic_failover" {
     type = bool
      default = false 
      }
variable "enable_multiple_write_locations" { 
    type = bool
     default = false 
     }
variable "enable_vnet_filter" { 
    type = bool
 default = false 
 }
variable "vnet_subnet_d" { 
    type = string
     default = ""
      } # subnet resource id for virtual_network_rule (if using vnet filter)

# throughput choices
variable "use_autoscale" { 
    type = bool
     default = true 
     }
variable "autoscale_max_ru" { 
    type = number
     default = 4000
      } # when use_autoscale = true
variable "throughput" { 
    type = number
 default = 400 
 }        # when use_autoscale = false

# variable "tfstate_resource_group_name" {
#   description = "Resource group name for Terraform remote state"
#   type        = string
#   default     = "tfstate-rg"
# }

# variable "tfstate_storage_account_name" {
#   description = "Storage account name for Terraform remote state (must be globally unique)"
#   type        = string
#   default     = "tfstatestorage123" # change to a unique name
# }

# variable "tfstate_container_name" {
#   description = "Blob container name for Terraform remote state"
#   type        = string
#   default     = "tfstate"
# }

# variable "tfstate_key" {
#   description = "Name of the state file key"
#   type        = string
#   default     = "cosmosdb.terraform.tfstate"
# }
