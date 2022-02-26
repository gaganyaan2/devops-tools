resource "aws_eks_node_group" "worker-dev-eks" {
  cluster_name    = "dev-eks"
  node_group_name = "worker-dev-eks"
  node_role_arn   = aws_iam_role.worker-dev-eks.arn
  subnet_ids      = ["subnet-093a2ddfcb7bc30b1", "subnet-0475d9e26dfdc9d00"]
  instance_types  = ["t3a.medium"]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }


  depends_on = [
    aws_iam_role_policy_attachment.worker-dev-eks-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.worker-dev-eks-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.worker-dev-eks-AmazonEC2ContainerRegistryReadOnly,
  ]
}


resource "aws_iam_role" "worker-dev-eks" {
  name = "eks-node-group-worker-dev-eks"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "worker-dev-eks-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.worker-dev-eks.name
}

resource "aws_iam_role_policy_attachment" "worker-dev-eks-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.worker-dev-eks.name
}

resource "aws_iam_role_policy_attachment" "worker-dev-eks-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.worker-dev-eks.name
}