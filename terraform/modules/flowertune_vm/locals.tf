locals {
  startup_script = var.startup_script != "" ? var.startup_script : "${path.module}/start_script.sh"
}