resource "aws_lb" "raneem_alb" {
    name = "raneem-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.raneem_sg.id]
    subnets = [aws_subnet.raneem_subnet_A.id, aws_subnet.raneem_subnet_B.id]

    tags = {
        name = "raneem-alb"
    }
}

resource "aws_lb_target_group" "raneem_tg" {
    name = "raneem-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.raneem_vpc.id
    health_check {
      path = "/"
      interval = 30
      timeout = 5
      healthy_threshold = 3
      unhealthy_threshold = 2
      matcher = "200-299"
    }
}

resource "aws_lb_listener" "raneem_listener" {
    load_balancer_arn = aws_lb.raneem_alb.arn
    port = 80
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.raneem_tg.arn
    }
}

resource "aws_lb_target_group_attachment" "raneem_tg_attachment_A" {
    target_group_arn = aws_lb_target_group.raneem_tg.arn
    target_id = aws_instance.raneem_ec2_A.id
    port = 80
}

resource "aws_lb_target_group_attachment" "raneem_tg_attachment_B" {
    target_group_arn = aws_lb_target_group.raneem_tg.arn
    target_id = aws_instance.raneem_ec2_B.id
    port = 80
}