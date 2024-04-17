
############## Module Outputs ################

output "subscriptions_details" {
  value = {
    for key, details in azurerm_subscription.create_subscription:
    key => details.subscription_id
  }
}