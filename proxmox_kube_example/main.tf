resource "proxmox_lxc" "kube" {
  count        = 3
  target_node  = "hulk"
  hostname     = "${count.index == 0 ? "kube-master" : "kube-slave-${count.index}"}"
  ostemplate   = "nasp:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
  password     = var.lxc_password
  unprivileged = true

  ssh_public_keys = <<-EOT
    ssh-rsa <public_key_1> user@example.com
  EOT

  rootfs {
    storage = "local-lvm"
    size    = "10G"
  }

  features {
    nesting      = true
    keyctl       = true
    fuse         = true
  }
# pct set <lxcid> -features nesting=1,keyctl=1,fuse=1 to provide the nesting features.

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "20.20.20.${150 + count.index}/24" # Ensure this IP range does not conflict with existing network assignments.
    ip6    = "auto"
  }
}

 