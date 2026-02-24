output "master_public_ip" {
  value = aws_instance.master.public_ip
}

output "compute_public_ips" {
  description = "Public IPs of compute nodes"
  value       = aws_instance.compute[*].public_ip
}