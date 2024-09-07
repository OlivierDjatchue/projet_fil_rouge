output "ec2_id_out" {
  value = aws_instance.my_ec2.id
}
output "availability_zone_out" {
  value = aws_instance.my_ec2.availability_zone
}