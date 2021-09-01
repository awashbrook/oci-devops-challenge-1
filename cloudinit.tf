data "template_file" "init-script" {
  template = file("scripts/init.cfg")
  vars = {
    region = var.oci_devops_general.region
  }
}

data "template_cloudinit_config" "cloudinit-app-server" {
  gzip          = false
  base64_encode = true

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.init-script.rendered
  }
  # TODO Remove
  part {
    content_type = "text/x-shellscript"
    content      = "#!/bin/bash\necho hello"
  }
}

