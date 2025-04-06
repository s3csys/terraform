variable "proxmox_PM_USER" {
  type = string
}

variable "proxmox_pm_api_url" {
  type = string
}

variable "proxmox_PM_API_TOKEN_ID" {
  type = string
  sensitive = true
}

variable "proxmox_PM_API_TOKEN_SECRET" {
  type = string
  sensitive = true
}

variable "proxmox_lxc_password" {
  type = string
  sensitive = true
}

