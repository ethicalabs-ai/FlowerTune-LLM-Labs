output "external_ip_address" {
  value = resource.cudo_vm.flowertune_vm.external_ip_address
}

output "internal_ip_address" {
  value = resource.cudo_vm.flowertune_vm.internal_ip_address
}

output "renewable_energy" {
  value = resource.cudo_vm.flowertune_vm.renewable_energy
}
