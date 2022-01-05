output "public_ip" {
  description = "ec2 private ip."
  value       = aws_instance.ap-web-01.public_ip
}


output "private_ip" {
  description = "ec2 private IP address."
  value       = aws_instance.ap-web-01.private_ip
}