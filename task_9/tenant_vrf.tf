resource "aci_tenant" "terraform_tenant" {
  name        = var.tenant_name
  description = "Created with Terraform"
}

resource "aci_vrf" "terraform_vrf" {
  tenant_dn = aci_tenant.terraform_tenant.id
  name      = var.vrf_name
}

