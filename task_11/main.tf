terraform {
  required_providers {
    mso = {
      source = "CiscoDevNet/mso"
    }
  }
}

provider "mso" {
  username = "admin"
  password = "C1sco12345"
  url      = "https://198.18.133.100"
  insecure = true
  platform = "nd"
}

