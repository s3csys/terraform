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

variable "vm_password" {
  type = string
  sensitive = true  
}

variable "vm_user" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "pm_node" {
  type = string
}

variable "storage_pool" {
  type = string
}

variable "network_bridge" {
  type = string
}

variable "template_name" {
  type = string
}

variable "proxmox_host" {
  type = string
}