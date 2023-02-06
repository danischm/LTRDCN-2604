/* Variables for our three-tier application */

variable "tenant_name" {
  default = "ciscolive"
}

variable "vrf_name" {
  default = "cl_vrf"
}

variable "bd_name" {
  type    = list(string)
  default = ["web-bd", "app-bd", "db-bd"]
}

variable "epg_name" {
  type    = list(string)
  default = ["web", "app", "db"]
}

variable "ap_name" {
  default = "cl_ap"
}

