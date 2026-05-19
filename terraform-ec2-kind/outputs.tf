output "ec2_public_ip" {
  value = aws_instance.kind_server.public_ip
}