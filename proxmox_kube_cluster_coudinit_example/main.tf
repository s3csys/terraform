locals {
  vms = [
    {
      name    = "Kube-Master"
      ip      = "XX.XX.XX.XX"
    },
    {
      name    = "Kube-Slave1"
      ip      = "XX.XX.XX.XX"
    },
    {
      name    = "Kube-Slave2"
      ip      = "XX.XX.XX.XX"
    },
  ]
}

resource "proxmox_vm_qemu" "kubernetes_cluster" {
  for_each    = { for vm in local.vms : vm.name => vm }

  desc        = "<div align='center'><a href='https://secsys.pages.dev' target='_blank' rel='noopener noreferrer'><img src='https://secsys.pages.dev/assets/img/logo.png' alt='SecSys Logo' style='width:41px;height:41px;border-radius:6px;margin:2px 0;'/></a><h2 style='font-size: 10px; margin: 4px 0;'>Kubernetes Cluster</h2><div style='margin: 4px 0; font-size: 10px;'><span>🌐 <a href='https://secsys.pages.dev' target='_blank' rel='noopener noreferrer' style='text-decoration: none; color: #00617f;'>SecSys</a></span> • <span>🔗 <a href='https://github.com/s3csys' target='_blank' rel='noopener noreferrer' style='text-decoration: none; color: #00617f;'>GitHub</a></span></div></div>"

  name        = each.value.name
  target_node = var.pm_node
  clone       = var.template_name
  full_clone  = true  # set to fase if you need the link clone
  agent       = 1
  os_type     = "cloud-init"
  cores       = 2
  sockets     = 1
  vcpus       = 0
  cpu_type    = "host"
  memory      = 2048
  scsihw      = "virtio-scsi-pci"

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = var.storage_pool
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size      = 10
          cache     = "writeback"
          storage   = var.storage_pool
          replicate = true
        }
      }
    }
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = var.network_bridge
  }

  boot       = "order=scsi0"
  ipconfig0  = "ip=${each.value.ip}/24,gw=XX.XX.XX.1"

  serial {
    id   = 0
    type = "socket"
  }

  ciuser     = var.vm_user
  cipassword = var.vm_password
  cicustom   = "user=local:snippets/cloudinit-${var.vm_name}.yml"
}
