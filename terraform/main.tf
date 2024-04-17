############## Module Config ################

# module "management_groups" {
#   source                        = "./modules/management_groups"
#   root_management_group_name    = var.root_management_group_name
#   layer1_management_group_names = var.layer1_management_group_names
#   layer2_management_group_names = var.layer2_management_group_names
#   layer3_management_group_names = var.layer3_management_group_names
# }


# module "subscriptions" {
#   source                      = "./modules/subscriptions"
#   depends_on                  = [module.management_groups]
#   subscription_settings       = var.subscription_settings
#}

########### Module of RBAC #############
module "role_based_access" {
  source = "./modules/role_based_access"
  rbac_mgaccess = var.rbac_mgaccess
  rbac_subaccess = var.rbac_subaccess
  rbac_rgaccess = var.rbac_rgaccess
}
