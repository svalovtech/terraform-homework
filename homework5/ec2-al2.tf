
data "aws_ami" "am-l" {
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

resource "aws_instance" "web-amazon" {
  ami           = data.aws_ami.am-l.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.pb1.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data = file("apache-amazon.sh")

  tags = {
    Name = "Amazon"
  }
}

output ec2-amazon {
    value = aws_instance.web-amazon.public_ip
}