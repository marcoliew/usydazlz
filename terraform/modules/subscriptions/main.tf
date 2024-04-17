
############## Module Config ################

data "azurerm_billing_enrollment_account_scope" "nonprod_billing_scope" {
  billing_account_name = var.billing_account_id
  enrollment_account_name  = var.nonprod_account_id
}

data "azurerm_billing_enrollment_account_scope" "prod_billing_scope" {
  billing_account_name = var.billing_account_id
  enrollment_account_name  = var.prod_account_id
}

resource "azurerm_subscription" "create_subscription" {
  for_each = {
    for index, value in var.subscription_settings :
    value.subscription_name => value
  }
  subscription_name = each.value.subscription_name
  billing_scope_id  = each.value.production_workload ? data.azurerm_billing_enrollment_account_scope.prod_billing_scope.id : data.azurerm_billing_enrollment_account_scope.nonprod_billing_scope.id
  workload          = each.value.production_workload ? "Production" : "DevTest"
}

data "azurerm_management_group" "management_group_id" {
  for_each = {
    for index, value in var.subscription_settings :
    value.management_group_name => value
  }
  display_name = each.value.management_group_name
}
 
resource "azurerm_management_group_subscription_association" "add_subscription_to_mg" {
  for_each = {
    for key, value in var.subscription_settings :
    key => value
  }
  management_group_id = data.azurerm_management_group.management_group_id[each.value.management_group_name].id
  subscription_id     = "/subscriptions/${resource.azurerm_subscription.create_subscription[each.value.subscription_name].subscription_id}"
}