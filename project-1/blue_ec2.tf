# data "aws_ami" "am_blue" {
#   most_recent = true
  
#   filter {
#     name   = "name"
#     values = ["al2023-ami-2023*-kernel-6.1-x86_64"]
#   }
#    filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
# }
# owners = ["137112412989"]
# }

# resource "aws_instance" "web" {
#   ami           = data.aws_ami.am_blue.id
#   instance_type = var.instance_type
#   subnet_id = aws_subnet.pb2.id
#   vpc_security_group_ids = [aws_security_group.allow_tls.id]
#   user_data = file("user-data.sh")

#   tags = {
#     Name = "green-group-4"
#   }
# }
