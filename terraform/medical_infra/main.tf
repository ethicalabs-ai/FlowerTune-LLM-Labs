# Never set the api key here, use "export TF_VAR_cudo_api_key=..."
variable "cudo_api_key" {
  type = string
}

variable "cudo_project_id" {
  type = string
}


module "llm_experiment" {
  source = "../modules/flowertune_vm"

  vm_id              = "flowertune-vm"
  cudo_api_key       = var.cudo_api_key
  cudo_project_id    = var.cudo_project_id
  datacenter_id      = "ca-montreal-3"
  machine_type       = "ice-lake-rtx-a5000"
  gpu_model          = "RTX A5000"
  memory_gib         = 16
  vcpus              = 4
  gpus               = 1
  boot_disk_image_id = "ubuntu-2204-nvidia-535-docker-v20241017"
  boot_disk_size_gib = 70
  ssh_key_source     = "user"
  startup_script     = "${path.module}/start_script.sh"
}

output "external_ip_address" {
  value = module.llm_experiment.external_ip_address
}

output "renewable_energy" {
  value = module.llm_experiment.renewable_energy
}
