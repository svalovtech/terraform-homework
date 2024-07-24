
data "aws_ami" "green" {
  most_recent = true
  
  filter {
    name   = "name"
    values = ["al2023-ami-2023*-kernel-6.1-x86_64"]
  }
   filter {
    name   = "virtualization-type"
    values = ["hvm"]
}
owners = ["137112412989"]
}

resource "aws_instance" "green-ec2" {
  ami           = data.aws_ami.green.id
  instance_type = var.ec2_ins[1].instance_type
  subnet_id = aws_subnet.pb2.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data = file("user-data.sh")

  tags = {
    Name = var.ec2_ins[1].name
  }
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


output ec2-amazon1 {
    value = aws_instance.green-ec2.public_ip
}