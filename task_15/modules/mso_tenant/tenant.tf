terraform {
  required_providers {
    mso = {
      source = "CiscoDevNet/mso"
    }
  }
}

variable "tenant_name" {
}

variable "site_1_id" {
}

variable "site_2_id" {
}

variable "template_name" {
  default = "SF_NY"
}

# Define an MSO Tenant between NY and SF
resource "mso_tenant" "tenant" {
  name         = var.tenant_name
  display_name = var.tenant_name
  description  = "This tenant was created by Terraform"
  site_associations { site_id = var.site_1_id }
  site_associations { site_id = var.site_2_id }
}

resource "mso_schema" "schema" {
  name = mso_tenant.tenant.name

  template {
    name         = var.template_name
    display_name = var.template_name
    tenant_id    = mso_tenant.tenant.id
  }
}

resource "mso_schema_site" "schema_site_SF" {
  schema_id     = mso_schema.schema.id
  site_id       = var.site_1_id
  template_name = var.template_name
}

resource "mso_schema_site" "schema_site_NY" {
  schema_id     = mso_schema.schema.id
  site_id       = var.site_2_id
  template_name = var.template_name
}

resource "mso_schema_template_vrf" "schema_vrf_VRF1" {
  schema_id    = mso_schema.schema.id
  template     = var.template_name
  name         = "VRF1"
  display_name = "VRF1"
}

resource "mso_schema_template_bd" "schema_bd" {
  for_each = toset(["BD1", "BD2", "BD3"])

  schema_id     = mso_schema.schema.id
  name          = each.value
  display_name  = each.value
  template_name = var.template_name
  vrf_name      = mso_schema_template_vrf.schema_vrf_VRF1.name
}

resource "mso_schema_template_anp" "schema_anp_ANP1" {
  schema_id    = mso_schema.schema.id
  template     = var.template_name
  name         = "ANP1"
  display_name = "ANP1"
}

resource "mso_schema_template_anp_epg" "schema_epg" {
  for_each = {
    "EPG1" = "BD1"
    "EPG2" = "BD2"
    "EPG3" = "BD3"
  }

  schema_id     = mso_schema.schema.id
  template_name = var.template_name
  anp_name      = mso_schema_template_anp.schema_anp_ANP1.name
  name          = each.key
  display_name  = each.key
  bd_name       = each.value
  vrf_name      = mso_schema_template_vrf.schema_vrf_VRF1.name
}

resource "mso_schema_template_deploy" "schema_deploy" {
  schema_id     = mso_schema.schema.id
  template_name = var.template_name
  depends_on = [
    mso_schema_site.schema_site_SF,
    mso_schema_site.schema_site_NY,
    mso_schema_template_vrf.schema_vrf_VRF1,
    mso_schema_template_bd.schema_bd,
    mso_schema_template_anp.schema_anp_ANP1,
    mso_schema_template_anp_epg.schema_epg,
  ]
}

