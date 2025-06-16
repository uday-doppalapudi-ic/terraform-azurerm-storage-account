resource "azurerm_storage_account" "example" {
  for_each                 = var.storage_accounts
  name                     = each.value.name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type

  dynamic "identity" {
    for_each = each.value.identity != null ? [1] : []

    content {
      type         = each.value.identity.type
      identity_ids = each.value.identity.identity_ids
    }
  }

  dynamic "network_rules" {
    for_each = each.value.network_rules != null ? [1] : []

    content {
      default_action             = each.value.network_rules.default_action
      bypass                     = each.value.network_rules.bypass
      virtual_network_subnet_ids = each.value.network_rules.virtual_network_subnet_ids
      ip_rules                   = each.value.network_rules.ip_rules

      dynamic "private_link_access" {
        for_each = each.value.network_rules.private_link_access != null ? [1] : []

        content {
          endpoint_resource_id = each.value.network_rules.private_link_access.endpoint_resource_id
          endpoint_tenant_id   = each.value.network_rules.private_link_access.endpoint_tenant_id
        }
      }
    }
  }

  tags = var.tags
}
