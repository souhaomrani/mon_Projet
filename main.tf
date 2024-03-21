provider "proxmox" {
  pm_api_url      = "https://192.168.127.134:8006/api2/json"
  pm_user         = "root"
  pm_password     = "rootroot"
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "ubuntu_vm" {
  name            = "ubuntu-vm"
  clone           = "template"  # Ajustez cela en fonction du nom de votre modèle
  target_node     = var.target_node
  target_storage  = var.target_storage
  full_clone      = true
  
  network {
    model   = "virtio"
    bridge  = var.bridge
  }
  
  disk {
    id       = 0
    storage  = var.target_storage
    size     = var.disk_size
  }
  
  os_type = var.os_type
}
