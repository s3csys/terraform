terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
}


provider "proxmox" {
  pm_user              = var.proxmox_PM_USER
  pm_api_url           = var.proxmox_pm_api_url
  pm_api_token_id      = var.proxmox_PM_API_TOKEN_ID
  pm_api_token_secret  = var.proxmox_PM_API_TOKEN_SECRET
  pm_tls_insecure      = true
  pm_debug             = true
  pm_log_enable        = true
  pm_log_file          = "terraform-plugin-proxmox.log"
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}
