# configures the required providers, and source.
terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = "2.6.1"
    }
  }
}

# configure provider with your cisco aci credentials.
provider "aci" {
  username = "admin"
  password = "C1sco12345"
  url      = "https://apic1-a.dcloud.cisco.com"
  insecure = true
}

