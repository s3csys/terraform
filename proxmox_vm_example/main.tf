resource "proxmox_vm_qemu" "cloudinit-test" {
    desc        = "testing the terraform and cloudinit"
    name        = var.vm_name
    target_node = var.pm_node
    clone       = var.template_name     # The template name to clone this vm from
    full_clone  = true
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
    ipconfig0 = "ip=20.20.20.150/24,gw=20.20.20.1"
    #ipconfig0 = "ip=dhcp"
    serial {
      id   = 0
      type = "socket"
    }
    
    ciuser = "var.vm_user"
    cipassword = var.vm_password
    cicustom = "user=local:snippets/cloudinit-${var.vm_name}.yml"
}