provider aws {
    region = "us-west-2"
}

resource "aws_key_pair" "hm3" {
  key_name   = "bastion"
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_ami" "linux-2" {
 most_recent = true


 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }


 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}

resource "aws_instance" "web-1" {

  ami           = data.aws_ami.linux-2.id
  instance_type = "t2.micro"
  availability_zone = element(["us-west-2a", "us-west-2b", "us-west-2c"], count.index)
  count = 3
  key_name = aws_key_pair.hm3.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data = file("user-data.sh")

  tags = {
     Name = "web-${count.index + 1}"
  }
}

  output ec1 {
    value = aws_instance.web-1[*].public_ip
}

