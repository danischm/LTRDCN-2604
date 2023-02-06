/*
    Creates the Application Profile and configures
    the EPGs -> Web, App, DB. Will be associated to contracts
    in a separate .tf file
*/

resource "aci_application_profile" "terraform_ap" {
  tenant_dn = aci_tenant.terraform_tenant.id
  name      = "terraform_ap"
}

resource "aci_application_epg" "web_epg" {
  description            = "Created with Terraform"
  application_profile_dn = aci_application_profile.terraform_ap.id
  name                   = "web"
  relation_fv_rs_bd      = aci_bridge_domain.web-bd.id
  relation_fv_rs_prov    = [aci_contract.web_app.id]
}

resource "aci_application_epg" "app_epg" {
  description            = "Created with Terraform"
  application_profile_dn = aci_application_profile.terraform_ap.id
  name                   = "app"
  relation_fv_rs_bd      = aci_bridge_domain.app-bd.id
  relation_fv_rs_cons    = [aci_contract.web_app.id]
  relation_fv_rs_prov    = [aci_contract.app_db.id]
}

resource "aci_application_epg" "db_epg" {
  description            = "Created with Terraform"
  application_profile_dn = aci_application_profile.terraform_ap.id
  name                   = "db"
  relation_fv_rs_bd      = aci_bridge_domain.db-bd.id
  relation_fv_rs_cons    = [aci_contract.app_db.id]
}

