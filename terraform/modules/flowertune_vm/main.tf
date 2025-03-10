resource "cudo_vm" "flowertune_vm" {
  id             = var.vm_id
  data_center_id = var.datacenter_id
  machine_type   = var.machine_type
  gpu_model      = var.gpu_model
  gpus           = var.gpus
  vcpus          = var.vcpus
  memory_gib     = var.memory_gib
  ssh_key_source = var.ssh_key_source
  ssh_keys       = var.ssh_keys
  boot_disk = {
    image_id = var.boot_disk_image_id
    size_gib = var.boot_disk_size_gib
  }
  start_script = templatefile("${path.module}/start_script.sh", {})
}
