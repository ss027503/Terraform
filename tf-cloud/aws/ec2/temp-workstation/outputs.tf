output "instance_ip_addr" {
  description = "Public IP of the new server"
  value = aws_instance.this.public_ip
}