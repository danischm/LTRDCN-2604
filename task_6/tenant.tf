resource "aci_vrf" "terraform_vrf" {
  tenant_dn = aci_tenant.terraform.id
  name      = var.vrf_name
}

resource "aci_tenant" "terraform" {
  name        = var.tenant_name
  description = "This tenant is created by terraform"
}

