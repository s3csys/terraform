resource "proxmox_lxc" "debain_lxc" {
  target_node  = "hulk"
  hostname     = "debian"
  ostemplate   = "nasp:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
  password     = "BasicLXCContainer"
  unprivileged = true
  unprivileged = true

  ssh_public_keys = <<-EOT
    ssh-rsa <public_key_1> user@example.com
  EOT

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "10G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "20.20.20.150/24"
    ip6    = "auto"
  }
}
