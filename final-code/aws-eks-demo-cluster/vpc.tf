resource "aws_vpc" "eks-vpc" {
  cidr_block         = var.vpc_cidr
  instance_tenancy   = "default"
  enable_dns_support = true

  tags = {
    Name = "eks-vpc"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.eks-vpc.id
  cidr_block              = var.public-subnet-1-cidr
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name                                        = "eks-public-subnet-1"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.eks-vpc.id
  cidr_block              = var.public-subnet-2-cidr
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name                                        = "eks-public-subnet-2"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id            = aws_vpc.eks-vpc.id
  cidr_block        = var.private-subnet-1-cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name                                        = "eks-private-subnet-1"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id            = aws_vpc.eks-vpc.id
  cidr_block        = var.private-subnet-2-cidr
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name                                        = "eks-private-subnet-2"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_security_group" "kubernetes_master" {
  name        = "kubernetes-master-sg"
  description = "Security group for EKS master control plane"
  vpc_id      = aws_vpc.eks-vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kubernetes-master-sg"
  }
}