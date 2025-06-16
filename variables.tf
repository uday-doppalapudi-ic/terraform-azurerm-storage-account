variable "storage_accounts" {
  description = "Storage account configuration"
  type = map(object({
    name                     = string
    resource_group_name      = string
    location                 = optional(string, "UK South")
    account_tier             = string
    account_replication_type = string

    identity = optional(object({
      type         = string
      identity_ids = optional(list(string), [])
    }))

    network_rules = optional(object({
      default_action             = string
      bypass                     = optional(list(string), [])
      virtual_network_subnet_ids = optional(list(string), [])
      ip_rules                   = optional(list(string), [])
      private_link_access = optional(object({
        endpoint_resource_id = string
        endpoint_tenant_id   = optional(string)
      }))
    }))
  }))
}
variable "tags" {
  description = "Tags to be applied to the storage account"
  type        = map(string)
  default     = {}

}
