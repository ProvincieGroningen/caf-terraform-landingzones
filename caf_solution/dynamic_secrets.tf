module "dynamic_keyvault_secrets" {
  source  = "aztfmod/caf/azurerm//modules/security/dynamic_keyvault_secrets"
  version = "5.7.11"

  # Below code does not work for dynamic secrets and is not the same as in caf_launchpad where it does work...
  #for_each = {
  #  for keyvault_key, secrets in try(var.dynamic_keyvault_secrets, {}) : keyvault_key => {
  #    for key, value in secrets : key => value
  #    if try(value.value, null) == null
  #  }
  #}

  for_each = try(var.dynamic_keyvault_secrets, {})

  settings = each.value
  keyvault = module.solution.keyvaults[each.key]
  objects  = module.solution
}
