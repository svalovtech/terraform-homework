
# Download terraform:
#    type in your terminal <wget https://releases.hashicorp.com/terraform/1.9.4/terraform_1.9.4_linux_amd64.zip>
#    type (run) <ls>
# Copy from ls "terraform_1.9.4_linux_amd64.zip"
# Install unzip :
#    type <sudo apt install unzip>
#    type <unzip terraform_1.9.4_linux_amd64.zip>
#    run <ls>
# Check for execution permission   
#    run <ls -l> 
# If not 
#    type <chmod +x terraform>
# Move terraform in binary folder 
#    type <sudo mv terraform /usr/local/bin>
# Check if it's  in binary folder 
#     run <terraform version>
# Delete zip file 
#     type <sudo rm -rf terraform_1.9.4_linux_amd64.zip>
# Create IAM role and modify your AIM-role

provider aws {
    region = var.region
}

resource "aws_key_pair" "ansible" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_rsa.pub")
}

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

resource "aws_instance" "ubuntu" {
  count                  = var.count-ec2
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name               = aws_key_pair.ansible.key_name
  
  tags = {
    Name = var.name
  }
}

output "ec2_ubuntu" {
  value = aws_instance.ubuntu[*].public_ip
}




#  run in terminal     <terraform apply -var-file ohio.tfvars -var-file virginia.tfvars -var-file california.tfvars -var-file oregon.tfvars>


