# 📄 cloud-init.tf - Generate and Upload Cloud-Init Config using Terraform
# 🧠 Reads the cloud-init user-data file with dynamic variables
data "template_file" "cloudinit_userdata" {
  template = file("${path.module}/files/cloudinit.yml")

  vars = {
    hostname = var.vm_name
    vm_user  = var.vm_user 
    ssh_key  = var.vm_ssh_key
  }
}

# 📝 Writes the rendered user-data to a local file
resource "local_file" "rendered_cloudinit" {
  content  = data.template_file.cloudinit_userdata.rendered
  filename = "${path.module}/rendered_cloudinit.yml"
}

# 🚀 Uploads the file using scp after rendering
resource "null_resource" "scp_cloudinit" {
  depends_on = [local_file.rendered_cloudinit]

  provisioner "local-exec" {
    command = <<EOT
      scp -i ${path.module}/files/id_rsa \
          -o StrictHostKeyChecking=no \
          ${local_file.rendered_cloudinit.filename} \
          root@${var.proxmox_host}:/var/lib/vz/snippets/cloudinit-${var.vm_name}.yml
    EOT
  }
}
