variable "vm_id" {
  description = "VM Identifier"
  type        = string
}

variable "datacenter_id" {
  description = "Datacenter Identifier"
  type        = string
}

variable "machine_type" {
  description = "Machine Type"
  type        = string
}

variable "gpu_model" {
  description = "GPU Model"
  type        = string
  default     = null
}

variable "gpus" {
  description = "GPUs"
  type        = number
  default     = 0
}

variable "vcpus" {
  description = "Number of VCPUs"
  type        = number
  default     = 4
}

variable "memory_gib" {
  description = "Memory (GiB)"
  type        = number
  default     = 8
}

variable "ssh_key_source" {
  description = "SSH Key Source (custom, project or user)"
  type        = string
  default     = "user"
}

variable "ssh_keys" {
  description = "List of SSH Keys (only when 'ssh_key_source' is set to 'custom')"
  type        = list(any)
  default     = null
}

variable "boot_disk_image_id" {
  description = "Boot Disk Image ID"
  type        = string
}

variable "boot_disk_size_gib" {
  description = "Boot Disk Image ID"
  type        = number
}

variable "cudo_api_key" {
  description = "CUDO API Key"
  type        = string
  default     = ""
}

variable "cudo_project_id" {
  description = "CUDO Project ID"
  type        = string
  default     = "flowertune-llm"
}
