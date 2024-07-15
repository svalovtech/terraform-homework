provider aws {
    region = var.region
}

resource "aws_key_pair" "deployer" {
  key_name   = "slava-hw6"
  public_key = file("~/.ssh/id_rsa.pub")
}