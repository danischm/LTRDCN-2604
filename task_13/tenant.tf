variable "tenant_name" {
  default = "CL"
}

# Define an MSO Tenant between NY and SF
resource "mso_tenant" "tenant" {
  name         = var.tenant_name
  display_name = var.tenant_name
  description  = "This tenant was created by Terraform"
  site_associations { site_id = data.mso_site.sf_site.id }
  site_associations { site_id = data.mso_site.ny_site.id }
}

