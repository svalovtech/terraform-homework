#Creates users1

resource "aws_iam_user" "u1" {
  name = "jenny"
}

resource "aws_iam_user" "u2" {
  name = "rose"
}

resource "aws_iam_user" "u3" {
  name = "lisa"
}

resource "aws_iam_user" "u4" {
  name = "jisoo"
}

#Creates users2

resource "aws_iam_user" "u5" {
  name = "jihyo"
}

resource "aws_iam_user" "u6" {
  name = "sana"
}

resource "aws_iam_user" "u7" {
  name = "momo"
}

resource "aws_iam_user" "u8" {
  name = "dahyun"
}

#Creates groups


resource "aws_iam_group" "g1" {
  name = "blackpink"
}

resource "aws_iam_group" "g2" {
  name = "twice"
}

#Add users to your groups

resource "aws_iam_group_membership" "t1" {
  name = "team1"

  users = [
    aws_iam_user.u1.name,
    aws_iam_user.u2.name,
    aws_iam_user.u3.name,
    aws_iam_user.u4.name,
    aws_iam_user.u9.name,
  ]

  group = aws_iam_group.g1.name
}

resource "aws_iam_group_membership" "t2" {
  name = "team2"

  users = [
    aws_iam_user.u5.name,
    aws_iam_user.u6.name,
    aws_iam_user.u7.name,
    aws_iam_user.u8.name,
    aws_iam_user.u10.name,
  ]

  group = aws_iam_group.g2.name
}

#Import users
#terraform import aws_iam_user.u9 miyeon
#terraform import aws_iam_user.u10 mina

resource "aws_iam_user" "u9" {
  name = "miyeon"
}

resource "aws_iam_user" "u10" {
  name = "mina"
}