############## art DevOps Group ##################
resource "aws_iam_group" "devops_black" {
  name = "devops_black"
}

resource "aws_iam_group_membership" "devops_black" {
  name = aws_iam_group.devops_black.name

  users = [
    aws_iam_user.denovo.name,
  ]

  group = aws_iam_group.devops_black.name
}


########### DevOps Assume Policies ####################
resource "aws_iam_group_policy_attachment" "devops_black" {
  count      = length(var.assume_policy_devops_black)
  group      = aws_iam_group.devops_black.name
  policy_arn = var.assume_policy_devops_black[count.index]
}

variable "assume_policy_devops_black" {
  description = "IAM Policy to be attached to user"
  type        = list(string)

  default = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
  ]
}
############### DevOps Basic Policy ##################
resource "aws_iam_group_policy" "devops_black" {
  name  = "devops_black"
  group = aws_iam_group.devops_black.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "*"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}




############### MFA Manager ###########################
resource "aws_iam_group_policy_attachment" "devops_black_rotatekeys" {
  group      = aws_iam_group.devops_black.name
  policy_arn = aws_iam_policy.RotateKeys.arn
}

resource "aws_iam_group_policy_attachment" "devops_black_selfmanagemfa" {
  group      = aws_iam_group.devops_black.name
  policy_arn = aws_iam_policy.SelfManageMFA.arn
}

resource "aws_iam_group_policy_attachment" "devops_black_forcemfa" {
  group      = aws_iam_group.devops_black.name
  policy_arn = aws_iam_policy.ForceMFA.arn
}

#######################################################
