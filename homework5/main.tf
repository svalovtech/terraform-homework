provider aws {
 region = "us-west-2" 
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr[0]
  enable_dns_support = var.vpc_cidr[0].dns_support
  enable_dns_hostnames = var.vpc_cidr[0].dns_hostnames
  tags = {
    Name = "kaizen"
  }


}
resource "aws_subnet" "pb1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet[0]
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet[0].subnet_name
  }
}

resource "aws_subnet" "pb2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet[1]
  availability_zone = "${var.region}b"
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet[1].subnet_name
  }
}

resource "aws_subnet" "pr1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet[3]
  availability_zone = "${var.region}c"
  map_public_ip_on_launch = false
  tags = {
    Name = var.subnet[3].subnet_name
  }
}


resource "aws_subnet" "pr2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet[4]
  availability_zone = "${var.region}d"
  map_public_ip_on_launch = false
  tags = {
    Name = var.subnet[4].subnet_name
  }
}

# resource "aws_nat_gateway" "ng" {
#   connectivity_type = "private"
#   subnet_id         = aws_subnet.pb1.id
# }

# resource "aws_nat_gateway" "ng2" {
#   connectivity_type = "private"
#   subnet_id         = aws_subnet.pb2.id
# }



resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = var.ing_name
  }
}

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

resource "aws_route_table" "pr_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  
  tags = {
    Name = var.rt_names[1]
  }
}

# resource "aws_route_table" "pr_rt" {
#   vpc_id = aws_vpc.vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_nat_gateway.ng.id
#   }
  
#   tags = {
#     Name = "private-rt"
#   }
# }

resource "aws_route_table_association" "pb1_a" {
  subnet_id      = aws_subnet.pb1.id
  route_table_id = aws_route_table.pb_rt.id
}

resource "aws_route_table_association" "pb2_a" {
  subnet_id      = aws_subnet.pb2.id
  route_table_id = aws_route_table.pb_rt.id
}

resource "aws_route_table_association" "pr1_a" {
  subnet_id      = aws_subnet.pr1.id
  route_table_id = aws_route_table.pr_rt.id
}

resource "aws_route_table_association" "pr2_a" {
  subnet_id      = aws_subnet.pr2.id
  route_table_id = aws_route_table.pr_rt.id
}