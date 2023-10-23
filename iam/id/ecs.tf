
# ecs ec2 role
resource "aws_iam_role" "ecs-ec2-role" {
  name = "ecs-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ecs-ec2-role" {
  name = "ecs-ec2-role"
  role = aws_iam_role.ecs-ec2-role.name
}

resource "aws_iam_role" "ecs-consul-server-role" {
  name               = "ecs-consul-server-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "ecs-ec2-role-policy" {
  name   = "ecs-ec2-role-policy"
  role   = aws_iam_role.ecs-ec2-role.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "ecs:CreateCluster",
              "ecs:DeregisterContainerInstance",
              "ecs:DiscoverPollEndpoint",
              "ecs:Poll",
              "ecs:RegisterContainerInstance",
              "ecs:StartTelemetrySession",
              "ecs:Submit*",
              "ecs:StartTask",
              "ecr:GetAuthorizationToken",
              "ecr:BatchCheckLayerAvailability",
              "ecr:GetDownloadUrlForLayer",
              "ecr:BatchGetImage",
              "logs:CreateLogStream",
              "logs:PutLogEvents"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:DescribeLogStreams"
            ],
            "Resource": [
                "arn:aws:logs:*:*:*"
            ]
        }
    ]
}
EOF

}

resource "aws_iam_role_policy" "ecs_ec2_universal" {
  name = "ecs-ec2-universal"
  role = aws_iam_role.ecs-ec2-role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid      = "AllowAnsibleDescribeEc2TagsAccess",
        Action   = "ec2:DescribeTags",
        Resource = "*",
        Effect   = "Allow"
      },
      {
        Sid    = "AllowVPCAccess",
        Effect = "Allow",
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeDhcpOptions",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeVpcs"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ec2:CreateNetworkInterfacePermission"
        ],
        Resource = "arn:aws:ec2:ap-northeast-2:${var.ACCOUNT_ID}:network-interface/*"
      },
      {
        Effect = "Allow",
        Action = [
          "ssm:ResumeSession",
          "ssm:DescribeSessions",
          "ssm:TerminateSession",
          "ssm:StartSession",
          "ssm:UpdateInstanceInformation",
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetEncryptionConfiguration"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ec2messages:AcknowledgeMessage",
          "ec2messages:DeleteMessage",
          "ec2messages:FailMessage",
          "ec2messages:GetEndpoint",
          "ec2messages:GetMessages",
          "ec2messages:SendReply"
        ],
        Resource = "*"
      },
      {
        Action = [
          "s3:GetObject"
        ],
        Effect = "Allow",
        Resource = [
          "arn:aws:s3:::amazonlinux.region.amazonaws.com/*",
          "arn:aws:s3:::amazonlinux-2-repos-region/*"
        ]
      }
    ]
  })
}


resource "aws_iam_role_policy" "kms" {
  name   = "ecs-ec2-kms-decryption"
  role   = aws_iam_role.ecs-ec2-role.id
  policy = <<EOF
{
  "Statement": [
    {
      "Sid": "AllowToDecryptKMSKey",
      "Action": [
        "kms:Decrypt"
      ],
      "Resource": [
        "${data.terraform_remote_state.kms_apne2.outputs.aws_kms_key_id_apne2_deployment_common_arn}"
      ],
      "Effect": "Allow"
    },
    {
      "Sid": "AllowSsmParameterAccess",
      "Action": [
        "ssm:GetParameter",
        "ssm:GetParameters"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:ap-northeast-2:${var.ACCOUNT_ID}:parameter/*"
      ]
    }
  ]
}
EOF
}


# ecs service role
resource "aws_iam_role" "ecs-service-role" {
  name               = "ecs-service-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}
resource "aws_iam_role_policy" "cloudmap_discovery" {
  name   = "ecs-cloudmap-discovery"
  role   = aws_iam_role.ecs-ec2-role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "servicediscovery:DiscoverInstances",
        "servicediscovery:GetInstancesHealthStatus",
        "servicediscovery:ListInstances"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}



resource "aws_iam_policy_attachment" "ecs-service-attach" {
  name       = "ecs-service-attach"
  roles      = [aws_iam_role.ecs-service-role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

output "aws_iam_instance_profile_ecs_ec2_role_id" {
  description = "aws_iam_instance_profile"
  value       = aws_iam_instance_profile.ecs-ec2-role.id
}

output "aws_iam_role_ecs_service_role_arn" {
  description = "aws_iam_role"
  value       = aws_iam_role.ecs-service-role.arn
}
