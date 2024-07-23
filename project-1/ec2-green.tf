
# data "aws_ami" "am-l1" {
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

# resource "aws_instance" "web-amazon1" {
#   ami           = data.aws_ami.am-l1.id
#   instance_type = var.ec2_ins[1].instance_type
#   subnet_id = aws_subnet.pb2.id
#   vpc_security_group_ids = [aws_security_group.allow_tls.id]
#   user_data = file("user-data.sh")

#   tags = {
#     Name = var.ec2_ins[1].name
#   }
# }

# output ec2-amazon1 {
#     value = aws_instance.web-amazon1.public_ip
# }