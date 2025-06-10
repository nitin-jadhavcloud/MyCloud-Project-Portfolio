provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}
 
 
 
 
 IAM Groups
resource "aws_iam_group" "cloud_ops_group" {
  name = "CloudOps_L1"
}

resource "aws_iam_group" "cloud_admin_group" {
  name = "CloudAdmins"
}

resource "aws_iam_group" "developers_group" {
  name = "Developers"
}

# IAM Users
resource "aws_iam_user" "cloud_ops" {
  name = "cloud_ops"
}

resource "aws_iam_user" "cloud_admin" {
  name = "cloud_admin"
}

resource "aws_iam_user" "developer" {
  name = "developer"
}

# IAM Group Memberships
resource "aws_iam_user_group_membership" "cloud_ops_group_membership" {
  user   = aws_iam_user.cloud_ops.name
  groups = [aws_iam_group.cloud_ops_group.name]
}

resource "aws_iam_user_group_membership" "cloud_admin_group_membership" {
  user   = aws_iam_user.cloud_admin.name
  groups = [aws_iam_group.cloud_admin_group.name]
}

resource "aws_iam_user_group_membership" "developer_group_membership" {
  user   = aws_iam_user.developer.name
  groups = [aws_iam_group.developers_group.name]
}

# Inline IAM Policies (no external files)

resource "aws_iam_policy" "cloud_ops_policy" {
  name        = "CloudOpsL1Policy"
  description = "Start/Stop EC2 and View Logs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:StartInstances",
          "ec2:StopInstances",
          "logs:Describe*",
          "ec2:DescribeInstances"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "cloud_admin_policy" {
  name        = "CloudAdminPolicy"
  description = "Full access to EC2, VPC, limited IAM"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:*",
          "vpc:*",
          "iam:PassRole"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "developer_policy" {
  name        = "DeveloperPolicy"
  description = "Access to S3, EC2 Describe, CodeDeploy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "ec2:Describe*",
          "codedeploy:*"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach Policies to Groups

resource "aws_iam_group_policy_attachment" "cloud_ops_attach" {
  group      = aws_iam_group.cloud_ops_group.name
  policy_arn = aws_iam_policy.cloud_ops_policy.arn
}

resource "aws_iam_group_policy_attachment" "cloud_admin_attach" {
  group      = aws_iam_group.cloud_admin_group.name
  policy_arn = aws_iam_policy.cloud_admin_policy.arn
}

resource "aws_iam_group_policy_attachment" "developer_attach" {
  group      = aws_iam_group.developers_group.name
  policy_arn = aws_iam_policy.developer_policy.arn
}
