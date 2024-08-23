output "vpc_id" {
    value = aws_vpc.raneem_vpc.id
}

output "alb_dns_name" {
    value = aws_lb.raneem_alb.dns_name
}

output "ec2_public_ips" {
    value = [aws_instance.raneem_ec2_A.public_ip, aws_instance.raneem_ec2_B.public_ip]
}