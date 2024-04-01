terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

provider "proxmox" {
  pm_api_url         = var.pm_api_url
  pm_api_token_id    = var.pm_user
  pm_api_token_secret = var.pm_password
  pm_tls_insecure    = true
}

resource "proxmox_vm_qemu" "ubuntu_vm" {
  name            = "ubuntu-vm"
  clone           = var.template
  target_node     = var.target_node
  full_clone      = true

  network {
    model   = "virtio"
    bridge  = var.bridge
  }

  disk {
    storage  = var.target_storage
    size     = var.disk_size
    type     = "scsi"
  }

  iso_drive {
    file = var.iso_path  # Chemin vers le fichier ISO sur le système Proxmox
  }

  os_type = var.os_type
}
