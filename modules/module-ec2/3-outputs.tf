output "nginx_ip" {
  value = aws_instance.ec2-webserver.public_ip
}


output "aws_ec2_instance_id" {
  value = aws_instance.ec2-webserver.id
}

output "ec2_public_ip" {
  value = aws_instance.ec2-webserver.public_ip
}


output "ec2_private_ip" {
   value = aws_instance.ec2-webserver.private_ip
}