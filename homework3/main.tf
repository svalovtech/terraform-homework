provider aws {
    region = "us-west-2"
}

resource "aws_key_pair" "hm3" {
  key_name   = "bastion"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "web-1" {

  ami           = "ami-03b039a920e4e8966"
  instance_type = "t2.micro"
  availability_zone = "us-west-2c"
  
  key_name = aws_key_pair.hm3.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data = file('user-data.sh')

  tags = {
    Name = "web-1"
  }
}

  resource "aws_instance" "web-2" {

  ami           = "ami-03b039a920e4e8966"
  instance_type = "t2.micro"
  availability_zone = "us-west-2a"
  
  key_name = aws_key_pair.hm3.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data = file('user-data.sh')

  tags = {
    Name = "web-2"
  }
  }

  resource "aws_instance" "web-3" {

  ami           = "ami-03b039a920e4e8966"
  instance_type = "t2.micro"
  availability_zone = "us-west-2b"
  
  key_name = aws_key_pair.hm3.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data = file('user-data.sh')

  
  tags = {
    Name = "web-3"
  }
}

