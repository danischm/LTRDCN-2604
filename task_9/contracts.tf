/*
    Creates the contracts between the EPGs.
    HTTPS between web and app
    SQL (1433) between app and db
    This also includes contract subjects and filters
*/

resource "aci_contract" "web_app" {
  tenant_dn = aci_tenant.terraform_tenant.id
  name      = "web_to_app"
}

resource "aci_contract_subject" "web_sub" {
  contract_dn                  = aci_contract.web_app.id
  name                         = "web_app_subject"
  relation_vz_rs_subj_filt_att = [aci_filter.allow_https.id]
}

resource "aci_filter" "allow_https" {
  tenant_dn = aci_tenant.terraform_tenant.id
  name      = "allow_https"
}

resource "aci_filter_entry" "https" {
  name        = "https"
  filter_dn   = aci_filter.allow_https.id
  ether_t     = "ip"
  prot        = "tcp"
  d_from_port = "https"
  d_to_port   = "https"
  stateful    = "yes"
}

resource "aci_contract" "app_db" {
  tenant_dn = aci_tenant.terraform_tenant.id
  name      = "app_to_db"
}

resource "aci_contract_subject" "db_sub" {
  contract_dn                  = aci_contract.app_db.id
  name                         = "app_db_subject"
  relation_vz_rs_subj_filt_att = [aci_filter.allow_sql.id]
}

resource "aci_filter" "allow_sql" {
  tenant_dn = aci_tenant.terraform_tenant.id
  name      = "allow_sql"
}

resource "aci_filter_entry" "sql" {
  name        = "https"
  filter_dn   = aci_filter.allow_sql.id
  ether_t     = "ip"
  prot        = "tcp"
  d_from_port = "1433"
  d_to_port   = "1433"
  stateful    = "yes"
}

