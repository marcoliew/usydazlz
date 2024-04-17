# ############## Modules Variables ################

#### Managementgroup RBAC Variables  ######
variable "rbac_mgaccess" {
  type = map(object({
    management_group_name = string
    ad_group_name         = string
    role_name             = string
  }))
}
#### Subscription RBAC Variables  ######
variable "rbac_subaccess" {
  description = "AD Group Name, subscription Access Role Name, Subscription ID"
  type        = map(object({
    role_name       = string
    ad_group_name   = string
    subscription_id = string
  }))
}

#### ResourceGroups RBAC Variables  ######
variable "rbac_rgaccess" {
  description = "AD Group Name, resourcegroup Access Role Name, Subscription ID, resourcegroupname"
  type        = map(object({
    role_name           = string
    subscription_id     = string
    ad_group_name       = string
    resource_group_name = string
  }))
}

