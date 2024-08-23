data "aws_ami" "lates_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


resource "aws_instance" "raneem_ec2_A" {
    ami = data.aws_ami.lates_amazon_linux.id
    instance_type = "t2.micro"
    subnet_id = aws_subnet.raneem_subnet_A.id
    associate_public_ip_address = true
    security_groups = [aws_security_group.raneem_sg.id]
    key_name = "my-key-pair"

    user_data = <<-EOF
                  #!/bin/bash
                  yum update -y
                  yum install docker -y                   

                  systemctl start docker
                  systemctl enable docker

                  docker run -d -p 9090:80 --name nginx-container nginx:latest


                   EOF

    tags = {
      Name = "raneem-ec2A"
    }
}

resource "aws_instance" "raneem_ec2_B" {
    ami = data.aws_ami.lates_amazon_linux.id
    instance_type = "t2.micro"
    subnet_id = aws_subnet.raneem_subnet_B.id
    associate_public_ip_address = true
    security_groups = [aws_security_group.raneem_sg.id]
    key_name = "my-key-pair"

    user_data = <<-EOF
                   #!/bin/bash
                   yum update -y
                   amazon-linux-extras install nginx1 -y
                   systemctl start nginx
                   systemctl enable nginx
                   yum install docker -y                 
                   systemctl start docker
                   systemctl enable docker

                   EOF

    tags = {
      Name = "raneem-ec2B"
    }
}

