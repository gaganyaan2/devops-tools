provider "aws" {
  region = "ap-south-1"
}

resource "aws_eks_cluster" "dev-eks" {
  name     = "dev-eks"
  role_arn = aws_iam_role.dev-eks.arn

  vpc_config {
    subnet_ids = ["subnet-093a2ddfcb7bc30b1", "subnet-0475d9e26dfdc9d00"]
  }

  depends_on = [
    aws_iam_role_policy_attachment.dev-eks-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.dev-eks-AmazonEKSVPCResourceController,
  ]
}

output "endpoint" {
  value = aws_eks_cluster.dev-eks.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.dev-eks.certificate_authority[0].data
}

resource "aws_iam_role" "dev-eks" {
  name = "eks-cluster-dev-eks"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "dev-eks-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.dev-eks.name
}

resource "aws_iam_role_policy_attachment" "dev-eks-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.dev-eks.name
}