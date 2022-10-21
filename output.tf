output "nat_gateway_ip" {
  value = aws_eip.nat_gateway_EIP.public_ip
}


output "instance_private_ip" {
  value = aws_instance.backend_server.private_ip
}