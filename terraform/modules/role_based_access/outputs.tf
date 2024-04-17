
############## Module Outputs ################
# ####### Output of Managementgroup variables ############
# output "management_group_access_ob" {
#   value = {
#     for key, value in azurerm_role_assignment.mg_access:
#     key => ({"management_group_name_id" = value.scope , "role_name" = value.role_definition_name , "ad_group_id" = value.principal_id})
#   }
# }

