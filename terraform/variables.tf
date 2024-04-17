
############# Modules Variables ################

variable "tenant_id" {
  description = "usyd tenant id"
  default = ""
}

variable "client_id" {
  description = "terraform spn client id"
  default = ""
}

variable "client_secret" {
  description = "terraform spn client id secret"
  default = ""
}

variable "environment" {
  description = "envinorment variable"
  default = ""
}

variable "root_management_group_name" {
  description = "Root Management Group Name"
  type = string
  default = ""
}

variable "layer1_management_group_names" {
  description = "The name of the layer 1 management groups and subscription IDs. A list of subscription ID is optional (useful if you want to create the layer2 level and put subscriptions there)"
  type = map(object({
    subscription_ids = optional(list(string), null)
  }))
  default = {}
}

variable "layer2_management_group_names" {
  description = "The name of the layer 2 management groups, subscription IDs and parent management group name. A list of subscription ID is optional (useful if you want to create the management groups only)"
  type = map(object({
    subscription_ids        = optional(list(string), null)
    parent_management_group = string
  }))
  default = {}
}

variable "layer3_management_group_names" {
  description = "The name of the layer 3 management groups, subscription IDs and parent management group name. A list of subscription ID is optional (useful if you want to create the management groups only)"
  type = map(object({
    subscription_ids        = optional(list(string), null)
    parent_management_group = string
  }))
  default = {}
}



variable "subscription_settings" {
    description = "Subscription Settings"
    type = map(object({
        subscription_name        = optional(string, "subscriptionname")
        management_group_name    = optional(string, "managementgroupname")
        production_workload      = optional(bool, "true")
    }))
}

############################ RBAC Module Variables ######################
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

