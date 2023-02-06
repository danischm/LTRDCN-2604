variable "tenants" {
}

module "tenant" {
  source      = "./modules/mso_tenant"
  for_each    = toset(var.tenants)
  tenant_name = each.value
  site_1_id   = data.mso_site.sf_site.id
  site_2_id   = data.mso_site.ny_site.id
}

