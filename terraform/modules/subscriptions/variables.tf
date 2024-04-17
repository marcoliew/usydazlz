
############## Modules Variables ################

variable "subscription_settings" {
    type = map(object({
        subscription_name     = optional(string, "")
        management_group_name = optional(string, "")
        production_workload   = optional(string, "")
    }))
}

variable "nonprod_account_id" {
  type = number
  default = "355305"
}

variable "prod_account_id" {
  type = number
  default = "355304"
}

variable "billing_account_id" {
  type = number
  default = "53210474"
}