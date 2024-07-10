# terraform-homework
How to create instanse

1. Clone the repository:
a) git clone <repository_url>
b) cd homework4

2.Initialize Terraform:

     terraform init

3.Create a file anyname.tfvars file with your configurations.(example.tfvars) You must provide all the required variables.  For example:

a)region = "us-east-1"
b)key_name = "any name"
c)count_ec2 = 1
d)availability_zone = "us-east-2a"
e)instance_type = "t2.micro"
f)ami_id = "ami-0d8c288225dc75373" # Example AMI ID, replace with a valid one
e)allow_ports = ["80", "22", "443","ports number"]

4.To deploy in a specific region, use this command in tour terminal:


a)[terraform apply -var-file anyname.tfvars]    example    terraform apply -var-file example.tfvars

5.After deployment, you can destroy the resources:

a)terraform destroy -var-file anyname.tfvars    example    terraform destroy -var-file example.tfvars

