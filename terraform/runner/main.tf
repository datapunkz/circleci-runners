terraform {

  required_version = ">= 0.13"

  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
    local = {
      source = "hashicorp/local"
    }
  }
  # This backend uses the terraform cloud for state.
  backend "remote" {
    organization = "datapunks"
    workspaces {
      name = "dorunner"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "terraform" {
  name = "ariv3ra@gmail.com"
}

resource "digitalocean_droplet" "dorunner" {
  image              = var.image_name
  name               = var.runner_name
  region             = var.region
  size               = var.node_size
  private_networking = true
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]
  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.ssh_pvt_key)
    timeout     = "3m"
  }
  #Upload runner agent install script
  provisioner "file" {
    source      = "runner-agent-install"
    destination = "/tmp/runner-agent-install"
  }

  #Upload runner provisioner script
  provisioner "file" {
    source      = "runner-provisioner"
    destination = "/tmp/runner-provisioner"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt update",
      "sudo apt -y upgrade",
      "cd /tmp",
      "chmod +x /tmp/runner-agent-install",
      "chmod +x /tmp/runner-provisioner",
      "/tmp/runner-agent-install ${var.runner_platform}",
      "/tmp/runner-provisioner ${var.runner_platform} ${var.runner_name} ${var.runner_token}",
    ]
  }
}

output ip_address {
  value       = digitalocean_droplet.dorunner.ipv4_address
  description = "The public ip address for the compute node"
}

output runner_name {
  value       = var.runner_name
  description = "The name of the runner node"
}
