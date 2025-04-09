resource "proxmox_vm_qemu" "minikube_cloudinit" {
    desc = "<div align='center'><a href='https://secsys.pages.dev' target='_blank' rel='noopener noreferrer'><img src='https://secsys.pages.dev/assets/img/logo.png' alt='SecSys Logo' style='width:41px;height:41px;border-radius:6px;margin:2px 0;'/></a><h2 style='font-size: 10px; margin: 4px 0;'>Minikube Setup</h2><div style='margin: 4px 0; font-size: 10px;'><span>🌐 <a href='https://secsys.pages.dev' target='_blank' rel='noopener noreferrer' style='text-decoration: none; color: #00617f;'>SecSys</a></span> • <span>🔗 <a href='https://github.com/s3csys' target='_blank' rel='noopener noreferrer' style='text-decoration: none; color: #00617f;'>GitHub</a></span></div></div>"
    name        = var.vm_name
    target_node = var.pm_node
    clone       = var.template_name     # The template name to clone this vm from
    full_clone  = true    # set to fase if you need the link clone
    agent       = 1         # Activate QEMU agent for this VM
    os_type     = "cloud-init"
    cores       = 2
    sockets     = 1
    vcpus       = 0
    cpu_type    = "host"
    memory      = 2048
    scsihw      = "virtio-scsi-pci"

    # Setup the disk
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
                    size            = 10
                    cache           = "writeback"
                    storage         = var.storage_pool
                    #storage_type    = "rbd"
                    #iothread        = true
                    #discard         = true
                    replicate       = true
                }
            }
        }
    }

    network {
        id = 0
        model = "virtio"
        bridge = var.network_bridge
    }

    # Setup the ip address using cloud-init.
    boot = "order=scsi0"
    ipconfig0 = "ip=XX.XX.XX.XX/24,gw=XX.XX.XX.1"
    #ipconfig0 = "ip=dhcp"
    serial {
      id   = 0
      type = "socket"
    }
    
    ciuser = "var.vm_user"
    cipassword = var.vm_password
    cicustom = "user=local:snippets/cloudinit-${var.vm_name}.yml"
}