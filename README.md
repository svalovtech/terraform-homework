# terraform-homework
How to create instanse

1. Clone the repository:
            **git clone <repository_url>**
            **cd homework4**

2.Initialize Terraform:

     terraform init

3.Create a file anyname.tfvars file with your configurations.(example.tfvars) You must provide all the required variables.  For example:

     region = "us-east-1"
     key_name = "any name"
     count_ec2 = 1
     availability_zone = "us-east-2a"
     instance_type = "t2.micro"
     ami_id = "ami-0d8c288225dc75373" # Example AMI ID, replace with a valid one
     allow_ports = ["80", "22", "443","ports number"]

4.To deploy in a specific region, use this command in tour terminal:


     [terraform apply -var-file anyname.tfvars]    example    terraform apply -var-file example.tfvars

5.After deployment, you can destroy the resources:

     terraform destroy -var-file anyname.tfvars    example    terraform destroy -var-file example.tfvars

