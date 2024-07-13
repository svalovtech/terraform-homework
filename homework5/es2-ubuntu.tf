data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web-ubunu" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.ec2_ins[1].instance_type
  subnet_id = aws_subnet.pb2.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data = file("apache-ubuntu.sh")

  tags = {
    Name = var.ec2_ins[1].name
  }
}

output ec2-ubuntu {
    value = aws_instance.web-ubunu.public_ip
}