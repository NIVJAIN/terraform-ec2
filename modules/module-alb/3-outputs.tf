# output "nginx_ip" {
#   value = aws_instance.ec2-webserver.public_ip
# }


# output "ec2_public_ip" {
#   value = aws_instance.ec2-webserver.public_ip
# }

output "aws_alb_dnsname" {
    value = aws_alb.alb.dns_name
}

output "aws_alb_zoneid" {
    value = aws_alb.alb.zone_id
}
