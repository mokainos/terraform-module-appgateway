data "azurerm_subscription" "current" {
}

data "azurerm_client_config" "current" {
}

locals {

  slug_location = lower(replace(var.location, " ", "."))

  frontend_port_name             = format("%s-appgw-%s-feport", var.network_shortname, var.environment)
  frontend_ip_configuration_name = format("%s-appgw-%s-feip", var.network_shortname, var.environment)
  frontend_prefix                = join("-", compact(["fe",var.cluster_number ]))

  x_fwded_proto_ruleset = "x_fwded_proto"

}



# data "null_data_source" "network_defaults" {
#   inputs = {
#     name_prefix = format("%s",
#       var.network_shortname
#     )

#     network_internal_zonename = format("%s.%s.%s",
#       var.network_shortname,
#       local.slug_location,
#       var.tag_environment
#     )
#   }
# }

# data "null_data_source" "tag_defaults" {
#   inputs = {
#     Project_Name         = var.tag_project_name
#     Environment          = var.tag_environment
#     Cost_Center          = var.tag_cost_center
#     App_Operations_Owner = var.tag_app_operations_owner
#     System_Owner         = var.tag_system_owner
#     Budget_Owner         = var.tag_budget_owner
#     Created_By           = "Terraform"
#   }
# }

# data "azurerm_subnet" "application_gateway_subnet" {
#   name = format("%s_application_gateway_%s",
#     var.network_shortname,
#     var.deploy_environment
#   )

#   virtual_network_name = var.network_name
#   resource_group_name  = var.resource_group_name

# }
