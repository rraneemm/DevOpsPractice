resource "aws_vpc" "raneem_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "vpc"
    }  
}

resource "aws_subnet" "raneem_subnet_A" {
    vpc_id = aws_vpc.raneem_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "eu-central-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "subnetA"
    }
}

resource "aws_subnet" "raneem_subnet_B" {
    vpc_id = aws_vpc.raneem_vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "eu-central-1b"
    tags = {
        Name = "subnetB"
    }
}

resource "aws_internet_gateway" "raneem_igw" {
    vpc_id = aws_vpc.raneem_vpc.id
    tags = {
        Name = "internet-gateway"
    }
}

resource "aws_route_table" "raneem_route_table" {
    vpc_id = aws_vpc.raneem_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.raneem_igw.id
    }

    tags = {
        Name = "raneem-route-table"
    }
}

resource "aws_route_table_association" "raneem_subnet_A_association" {
    subnet_id = aws_subnet.raneem_subnet_A.id
    route_table_id = aws_route_table.raneem_route_table.id
}

resource "aws_route_table_association" "raneem_subnet_B_association" {
    subnet_id = aws_subnet.raneem_subnet_B.id
    route_table_id = aws_route_table.raneem_route_table.id
}