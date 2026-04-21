output "ec2_public_ip" {
  description = "public ip of ec2"
  value = aws_instance.app-server.public_ip
}

output "ec2_public_dns" {
  description = "Public DNS of EC2"
  value = aws_instance.app-server.public_dns
}

output "rds_endpoint" {
    description = "endpoint of rds database"
    value = aws_db_instance.rds.endpoint
}

output "alb_dns_name" {
  description = "DNS of application loadbalancer"
  value = aws_lb.app_lb.dns_name
}
