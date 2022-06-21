
# Outputs
output "public_ip_address" {
  value = aws_instance.amazon_linux_2_server.public_ip
}

output "server_public_dns" {
  value = aws_instance.amazon_linux_2_server.public_dns
}

output "name" {
  value = aws_security_group.sg_rds_ssh_http.vpc_id
}