provider aws {
    region = "us-east-2"
}

resource "aws_key_pair" "Bastion" {
  key_name   = "Bastion-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

#Buckets s3

resource "aws_s3_bucket" "bucket1" {
  bucket = "kaizen-slava1"
}

resource "aws_s3_bucket" "bucket2" {
bucket_prefix =  "kaizen-"
}

#terraform import aws_s3_bucket.bucket3 kaizen-slava2
resource "aws_s3_bucket" "bucket3" {
  bucket = "kaizen-slava2"
}

#aws_s3_bucket.bucket4 kaizen-slava3
resource "aws_s3_bucket" "bucket4" {
  bucket = "kaizen-slava3"
}

#Creates users:

resource "aws_iam_user" "users" {
  for_each = toset(["jenny","rose","lisa","jisoo"])
  name = each.key
}

#Create group

resource "aws_iam_group" "group" {
  name = "blackpink" 
}

#Add users:

resource "aws_iam_group_membership" "team" {
  name = "add_users"

  users = [
    for u in aws_iam_user.users : u.name
  ]

  group = aws_iam_group.group.name
}
