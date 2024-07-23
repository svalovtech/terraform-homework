provider aws {
 region = var.region 
}

resource "aws_key_pair" "bastion" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_rsa.pub")
}
#/////////////////////////////////////Create VPC//////////////////////

resource "aws_vpc" "group-4" {
  cidr_block = var.vpc_cidr[0].cidr_block
  enable_dns_support = var.vpc_cidr[0].dns_support
  enable_dns_hostnames = var.vpc_cidr[0].dns_hostnames
 tags = {
    Name = "group-4"
  } 


#///////////////////////////////////Create Subnets////////////////////

}
resource "aws_subnet" "pb1" {
  vpc_id     = aws_vpc.group-4.id
  cidr_block = var.subnet[0].cidr
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true
  
}

resource "aws_subnet" "pb2" {
  vpc_id     = aws_vpc.group-4.id
  cidr_block = var.subnet[1].cidr
  availability_zone = "${var.region}b"
  map_public_ip_on_launch = true
  
}

resource "aws_subnet" "pb3" {
  vpc_id     = aws_vpc.group-4.id
  cidr_block = var.subnet[2].cidr
  availability_zone = "${var.region}c"
  map_public_ip_on_launch = true
  
}



#/////////////////////////////////Create Internet Gateway///////////////////////////

resource "aws_internet_gateway" "group_4" {
  vpc_id = aws_vpc.group-4.id
  tags = {
    Name = "group-4"
  } 
  
}

#//////////////////////////////////////Create Route Table/////////////////////////////

resource "aws_route_table" "pb_rt" {
  vpc_id = aws_vpc.group-4.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.group_4.id
  }
  
}

#//////////////////////////////////////Route Table Association/////////////////////////

resource "aws_route_table_association" "pb1_a" {
  subnet_id      = aws_subnet.pb1.id
  route_table_id = aws_route_table.pb_rt.id
}

resource "aws_route_table_association" "pb2_a" {
  subnet_id      = aws_subnet.pb2.id
  route_table_id = aws_route_table.pb_rt.id
}

resource "aws_route_table_association" "pb3_a" {
  subnet_id      = aws_subnet.pb3.id
  route_table_id = aws_route_table.pb_rt.id
}

#//////////////////////////////////Launch Template////////////////

# resource "aws_launch_template" "b-g-d" {
#   name = "l_t-b-g-d"
#   image_id = data.aws_ami.am_blue.id
#   instance_type = var.ec2_ins[0]
#   vpc_security_group_ids = [aws_security_group.allow_tls.id]
#   user_data = filebase64("${path.module}/user-data.sh")
# }

#///////////////////////////////////Autoscaling Group//////////////////

# resource "aws_autoscaling_group" "asg_b-g-d" {
#   name                = "asg_g4-${aws_launch_template.b-g-d.latest_version}"
#   min_size            = 2
#   max_size            = 2
#   min_elb_capacity    = 2
#   health_check_type   = "ELB"
#   vpc_zone_identifier = [aws_subnet.pb1.id ,aws_subnet.pb2.id ,aws_subnet.pb3.id]
#   target_group_arns   = [aws_lb_target_group.web.arn]

#   launch_template {
#     id      = aws_launch_template.b-g-d.id
#     version = aws_launch_template.b-g-d.latest_version
#   }
#     lifecycle {
#     create_before_destroy = true
#   }
# }
#/////////////////////////////////Load bala