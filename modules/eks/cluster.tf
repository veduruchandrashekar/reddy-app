#Create IAM Role for the Cluster,Attach Policy to Role and Create a Cluster

resource "aws_iam_role" "democlusterrole" {
  name = "democlusterrole"

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

resource "aws_iam_role_policy_attachment" "democlusterrole-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.democlusterrole.name
}

resource "aws_eks_cluster" "democluster" {
  name     = "democluster"
  role_arn = aws_iam_role.democlusterrole.arn

  vpc_config {
    subnet_ids = [
      var.subnet_id1,
      var.subnet_id2
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.democlusterrole-AmazonEKSClusterPolicy]
}

# Create IAM Role for the Worker Nodes, Attach Policies to Role and Create Worker Nodes 

resource "aws_iam_role" "demonoderole" {
  name = "demonodes"

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

resource "aws_iam_role_policy_attachment" "demonoderole-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.demonoderole.name
}

resource "aws_iam_role_policy_attachment" "demonoderole-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.demonoderole.name
}

resource "aws_iam_role_policy_attachment" "demonoderole-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.demonoderole.name
}

resource "aws_eks_node_group" "demonodes" {
  cluster_name    = aws_eks_cluster.democluster.name
  node_group_name = "demonodes"
  node_role_arn   = aws_iam_role.demonoderole.arn

  subnet_ids = [
    var.subnet_id1,
    var.subnet_id2
  ]

  capacity_type  = "ON_DEMAND"
  instance_types = ["t2.medium"]

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  update_config {
    max_unavailable = 2
  }

  labels = {
    role = "general"
  }
  depends_on = [
    aws_iam_role_policy_attachment.demonoderole-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.demonoderole-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.demonoderole-AmazonEC2ContainerRegistryReadOnly,
  ]
}
