##### SERVER USER ######
resource "aws_iam_user" "api_server" {
  name = "api_server"
}







##### IAM Group ######
resource "aws_iam_group" "server" {
  name = "server"

}

resource "aws_iam_group_membership" "server" {
  name = aws_iam_group.server.name
  users = [
    aws_iam_user.api_server.name,
  ]

  group = aws_iam_group.server.name
}

##### IAM Group Policy ######
resource "aws_iam_group_policy" "server" {
  name  = "server"
  group = aws_iam_group.server.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1618510000000",
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::hoit-medicines/*"
            ]
        }
    ]
}
EOF
}






