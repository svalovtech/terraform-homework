provider aws {
 region = var.region 
}
#///////////////////////////////////// Create Public Key ///////////////

resource "aws_key_pair" "bastion" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_rsa.pub")
}
#/////////////////////////////////////Create VPC//////////////////////

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr[0].cidr_block
  enable_dns_support = var.vpc_cidr[0].dns_support
  enable_dns_hostnames = var.vpc_cidr[0].dns_hostnames
  tags = {
    Name = "group-4"
  }
}

#///////////////////////////////////Create Subnets////////////////////


resource "aws_subnet" "pb1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet[0].cidr
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet[0].subnet_name
  }
}

resource "aws_subnet" "pb2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet[1].cidr
  availability_zone = "${var.region}b"
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet[1].subnet_name
  }
}

resource "aws_subnet" "pb3" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet[2].cidr
  availability_zone = "${var.region}c"
  map_public_ip_on_launch = false
  tags = {
    Name = var.subnet[2].subnet_name
  }
}



#/////////////////////////////////Create Internet Gateway///////////////////////////

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = var.ing_name
  }
}

#//////////////////////////////////////Create Route Table/////////////////////////////

resource "aws_route_table" "pb_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  
  tags = {
    Name = var.rt_names[0]
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

#///////////////////////////////// Load Balancer //////////////////////////////////////////

resource "aws_lb" "web" {
  name               = "lb-group-4"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_tls.id]
  subnets            = [aws_subnet.pb1.id ,aws_subnet.pb2.id ,aws_subnet.pb3.id]
  internal           = false
}

#///////////////////////////////// Load Balancer Target Group Blue /////////////////////////////

resource "aws_lb_target_group" "blue-group" {
  name                 = "ltg-group-4"
  vpc_id               = aws_vpc.vpc.id
  port                 = 80
  protocol             = "HTTP"
  
   health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    protocol            = "HTTP"
    interval            = 10
    port                = 80
  }
  }
#/////////////////////////////////// Load Balancer Target Group Attachment Blue /////////////////

  resource "aws_lb_target_group_attachment" "blue" {
  target_group_arn = aws_lb_target_group.blue-group.arn
  target_id        = aws_instance.blue-ec2.id
  port             = 80
}


#///////////////////////////////// Load Balancer Target Group Green /////////////////////////////

resource "aws_lb_target_group" "green-group" {
  name                 = "ltg-group-4"
  vpc_id               = aws_vpc.vpc.id
  port                 = 80
  protocol             = "HTTP"
  
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    protocol            = "HTTP"
    interval            = 10
    port                = 80
  }
}

#/////////////////////////////////// Load Balancer Target Group Attachment Green /////////////////

resource "aws_lb_target_group_attachment" "green" {
  target_group_arn = aws_lb_target_group.green-group.arn
  target_id        = aws_instance.green-ec2.id
  port             = 80
}


#/////////////////////////////////// Load Balancer Listener /////////////////////////////////////

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue-group.arn
  }
}
#///////////////////////////////////// Ouputs /////////////////////////////////////////////////
output "web_loadbalancer_url" {
  value = aws_lb.web.dns_name
}
