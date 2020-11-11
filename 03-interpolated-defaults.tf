data "azurerm_subscription" "current" {
}

data "azurerm_client_config" "current" {
}

locals {

  slug_location = lower(replace(var.location, " ", "."))

# frontend_port_name             = format("%s_application_gateway_%s_feport", var.network_shortname, var.deploy_environment)
# frontend_ip_configuration_name = format("%s_application_gateway_%s_feip", var.network_shortname, var.deploy_environment)


  criticality = {
    sbox     = "Low"
    aat      = "High"
    stg      = "High"
    prod     = "High"
    ithc     = "Medium"
    test     = "Medium"
    perftest = "Medium"
    demo     = "Medium"
    dev      = "Low"
  }

  env_display_names = {
    sbox     = "Sandbox"
    aat      = "Staging"
    stg      = "Staging"
    prod     = "Production"
    ithc     = "ITHC"
    test     = "Test"
    perftest = "Test"
    dev      = "Development"
    demo     = "Demo"
  }

  common_tags = {
    "managedBy"          = "SS DevOps"
    "solutionOwner"      = "Shared Services"
    "activityName"       = var.activity_name
    "dataClassification" = "Internal"
    "automation"         = "SS AKS Build Infrastructure"
    "costCentre"         = "ss-aks" // until we get a better one, this is the generic cft contingency one
    "environment"        = local.env_display_names[var.environment]
    "criticality"        = local.criticality[var.environment]
  }
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