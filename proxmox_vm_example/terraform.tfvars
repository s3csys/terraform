proxmox_pm_api_url = "https://$IP:8006/api2/json"

proxmox_PM_USER = "terraform@pve"
proxmox_PM_API_TOKEN_ID = "terraform@pve!terraform"
proxmox_PM_API_TOKEN_SECRET = "ffb26b21-abcd-defg-hijkl-01feffc7e6e4"

vm_name = "cloudinit"
pm_node = "pve"
storage_pool = "local-lvm"
network_bridge = "vmbr0"
template_name = "$VM_ID"
proxmox_host = "XX.XX.XX.XX"
vm_password = "XXXXXX"
vm_user = "XXXXXX"