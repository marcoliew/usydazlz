#### Block for Managementgroups RBAC ######
data "azurerm_management_group" "mg" {
  for_each = var.rbac_mgaccess

  display_name = each.value.management_group_name
}

data "azuread_group" "group" {
  for_each = var.rbac_mgaccess

  display_name     = each.value.ad_group_name
  security_enabled = true
}

resource "azurerm_role_assignment" "mg_access" {
  for_each = var.rbac_mgaccess

  scope                = data.azurerm_management_group.mg[each.key].id
  role_definition_name = each.value.role_name
  principal_id         = data.azuread_group.group[each.key].id
}

#### Block for Subscriptions RBAC ######
data "azuread_group" "subgroup" {
  for_each = {
    for key, value in var.rbac_subaccess :
    "${value.ad_group_name}_${value.subscription_id}" => value
  }
  display_name     = each.value.ad_group_name
  security_enabled = true
}

resource "azurerm_role_assignment" "subscription_access" {
  for_each = {
    for key, value in var.rbac_subaccess  :
    key => value
  }
  
  scope                = "/subscriptions/${each.value.subscription_id}"
  role_definition_name = each.value.role_name
  principal_id         = data.azuread_group.subgroup["${each.value.ad_group_name}_${each.value.subscription_id}"].id
}

#### Block for resourcegroup RBAC ######
data "azuread_group" "rggroup" {
  for_each = {
    for key, value in var.rbac_rgaccess :
    "${value.ad_group_name}_${value.subscription_id}" => value
  }
  display_name     = each.value.ad_group_name
  security_enabled = true
}

resource "azurerm_role_assignment" "resource_group_access" {
  for_each = {
    for key, value in var.rbac_rgaccess :
    key => value
  }
  scope                = "/subscriptions/${each.value.subscription_id}/resourceGroups/${each.value.resource_group_name}"
  role_definition_name = each.value.role_name
  principal_id         = data.azuread_group.rggroup["${each.value.ad_group_name}_${each.value.subscription_id}"].id
}
