output "vm_priv_pips" {
  value = [for vm in aws_instance.main : vm.private_ip ]
}
