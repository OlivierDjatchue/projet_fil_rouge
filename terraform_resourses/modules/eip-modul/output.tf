output "elastic_ip_out" {
  description = "The public IP address of the Elastic IP"
  value       = aws_eip.my_eip.public_ip
}

output "allocation_id_out" {
  description = "The allocation ID of the Elastic IP"
  value       = aws_eip.my_eip.id
}
